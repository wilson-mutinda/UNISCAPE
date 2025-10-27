class ContactService

  include SearchHelper
  include RegexHelper

  def initialize(params = {})
    @params = params || {}
    @contacts = Contact.all.order(:id).to_a
    @target_param = @params[:slug]
  end

  def create_contact
    # name_param
    name_param = normalize_name_param
    if name_param.is_a?(Hash) && name_param.key?(:errors)
      return name_param
    end

    # email_param
    email_param = normalize_email_param
    return email_param if email_param.is_a?(Hash) && email_param.key?(:errors)
    
    # message_param
    message_param = normalize_message_param
    return message_param if message_param.is_a?(Hash) && message_param.key?(:errors)

    # create_contact
    created_contact = Contact.new(
      name: name_param,
      email: email_param,
      message: message_param
    )

    if created_contact.save
      { success: true, message: "Contact created successfully!", info: created_contact }
    else
      { success: false, errors: created_contact.errors.full_messages }
    end
  end

  # view single_contact
  def single_contact
    contact  = contact_search_by_id(@contacts, @target_param)
    if contact.is_a?(Hash) && contact.key?(:errors)
      { success: false, errors: contact[:errors] }
    else
      { success: true, info: contact}
    end
  end

  # view all_contacts
  def all_contacts
    contacts = @contacts
    if contacts.empty?
      { success: false, errors: { contacts: "Empty List!"}}
    else
      { success: true, info: contacts }
    end
  end

  # update_contact
  def update_contact
    contact = contact_search_by_id(@contacts, @target_param)
    return contact if contact.is_a?(Hash) && contact.key?(:errors)

    # empty list to hold updates
    updates = {}

    # name_param
    if @params.key?(:name)
      name_param = normalize_update_name_param
      if name_param.is_a?(Hash) && name_param.key?(:errors)
        return name_param
      end
      updates[:name] = name_param
    end

    # email_param
    if @params.key?(:email)
      email_param = normalize_update_email_param
      if email_param.is_a?(Hash) && email_param.key?(:errors)
        return email_param
      end
      updates[:email] = email_param
    end

    # message_param
    if @params.key?(:message)
      message_param = normalize_update_message_param
      if message_param.is_a?(Hash) && message_param.key?(:errors)
        return message_param
      end
      updates[:message] = message_param
    end

    # update_param
    updated_param = contact.update(updates)
    if updated_param
      { success: true, message: "Contact updated successfully!", info: contact}
    else
      { success: false, errors: contact.errors.full_messages }
    end
  end

  # delete_contact
  def delete_contact
    contact = contact_search_by_id(@contacts, @target_param)
    if contact.is_a?(Hash) && contact.key?(:errors)
      return contact
    end

    soft_deleted = contact.soft_delete
    if soft_deleted
      { success: true, message: "Contact soft deleted successfully!"}
    else
      { success: false, errors: contact.errors.full_messages }
    end
  end

  # restore_contact
  def restore_contact
    @contact = Contact.unscoped.find_by(slug: @target_param)
    return { success: false, errors: { contact: "Contact not found!"}} if @contact.nil?
    return { success: false, errors: { contact: "Contact not deleted!"}} unless @contact.deleted?

    if @contact.restore
      { success: true, message: "Country restored successfuly!"}
    else
      { success: false, errors: @contact.errors.full_messages }
    end
  end
  
  private

  # normalize_update_name_param
  def normalize_update_name_param
    name_param = @params[:name].to_s
    if name_param.present?
      name_param
    end
  end

  # normalize_update_email_param
  def normalize_update_email_param
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.present?
      normalized = normalized_email(email_param)
      if normalized.is_a?(Hash) && normalized.key?(:errors)
        return normalized
      end
      normalized
    end
  end

  # normalize_update_message_param
  def normalize_update_message_param
    message_param = @params[:message].to_s
    if message_param.present?
      message_param
    end
  end

  # normalize_name_param
  def normalize_name_param
    name_param = @params[:name].to_s
    return { errors: "Name is required!"} if name_param.blank?
    name_param.to_s.titleize
  end

  # normalize_email_param
  def normalize_email_param
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    return  {errors: "Email is required!"} if email_param.blank?

    normalized = normalized_email(email_param)
    if normalized.is_a?(Hash) && normalized.key?(:errors)
      return normalized
    end

    normalized
  end

  # normalize_message_param
  def normalize_message_param
    message_param = @params[:message].to_s
    return { errors: "Message is required!"} if message_param.blank?

    message_param
  end
end