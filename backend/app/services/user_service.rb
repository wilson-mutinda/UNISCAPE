class UserService

  include RegexHelper
  include SearchHelper
  include SortHelper

  def initialize(params)
    @params = params
    @users = User.all.order(:email).to_a
    @target_param = params[:slug]
  end

  # create_user
  def create_user
    email_param = normalize_email
    if email_param.is_a?(Hash)
      return email_param
    end

    phone_param = normalize_phone
    if phone_param.is_a?(Hash)
      return phone_param
    end

    password_data = normalize_password
    if password_data.is_a?(Hash) && password_data.key?(:errors)
      return password_data
    end

    # create_user
    user = User.create(
      email: email_param,
      phone: phone_param,
      password: password_data[:password],
      password_confirmation: password_data[:password_confirmation],
      flag: 'Admin'
    )
    if user
      { success: true, user: user}
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  # update_user
  def update_user

    updated_user_params = {}

    @user = user_slug_search(@users, @target_param)

    if @user.is_a?(Hash) && @user[:errors]
      return @user
    end

    email_param = normalize_update_email
    if email_param.is_a?(Hash)
      return email_param
    end
    updated_user_params[:email] = email_param

    phone_param = normalize_update_phone
    if phone_param.is_a?(Hash)
      return phone_param
    end
    updated_user_params[:phone] = phone_param

    password_data = normalize_password
    if password_data.is_a?(Hash) && password_data.key(:errors)
      return password_data
    end
    updated_user_params[:password] = password_data[:password]
    updated_user_params[:password_confirmation] = password_data[:password_confirmation]

    # update_user
    updated_user = @user.update(updated_user_params)
    if updated_user
      { success: true, user: updated_user}
    else
      { success: false, errors: updated_user.errors.full_messages }
    end
  end

  private
  # normalize_email
  def normalize_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.blank?
      return { errors: { email: "Please input email!"}}
    end

    # email_format
    normalized = normalized_email(email_param)
    if normalized.is_a?(Hash)
      return normalized
    end

    # email should not exist
    existing = user_email_search(@users, normalized)
    if existing.is_a?(Hash)
      return existing
    end

    normalized
  end

  # normalize_phone
  def normalize_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.blank?
      return { errors: { phone: "Please input phone number!"}}
    end

    # phone_format
    normalized = normalized_phone(phone_param)
    if normalized.is_a?(Hash)
      return normalized
    end

    # phone should not exist
    existing = user_phone_search(@users, normalized)
    if existing.is_a?(Hash)
      return existing
    end

    normalized
  end

  # normalize_update_email
  def normalize_update_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.present?

      # email_format
      normalized = normalized_email(email_param)
      if normalized.is_a?(Hash)
        return normalized
      end

      # email should not exist
      existing = unique_email_search(@users, normalized, @user.id)
      if existing.is_a?(Hash)
        return existing
      end
    end
    normalized
  end

  # normalize_update_phone
  def normalize_update_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.present?

      # phone_format
      normalized = normalized_phone(phone_param)
      if normalized.is_a?(Hash)
        return normalized
      end

      # phone should not exist
      existing = unique_phone_search(@users, normalized, @user.id)
      if existing.is_a?(Hash)
        return existing
      end
    end
    normalized
  end

  # normalize_password
  def normalize_password
    normalized_password(@params[:password], @params[:password_confirmation])
  end
end