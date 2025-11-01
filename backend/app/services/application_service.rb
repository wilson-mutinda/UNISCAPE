class ApplicationService

  include RegexHelper
  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @students = Application.unscoped.order(:email).to_a
    @courses = Course.unscoped.order(:id).to_a
    @countrys = Country.unscoped.order(:id).to_a
    @applications = Application.unscoped.order(:slug).to_a
    @target_param = params[:slug]
  end

  # create_application
  def create_application
    Application.transaction do
      # first_name_param
      first_name_param = normalize_first_name
      return first_name_param if first_name_param.is_a?(Hash) && first_name_param.key?(:errors)

      # last_name_param
      last_name_param = normalize_last_name
      return last_name_param if last_name_param.is_a?(Hash) && last_name_param.key?(:errors)

      # email_param
      email_param = normalize_email
      return email_param if email_param.is_a?(Hash) && email_param.key?(:errors)

      # phone_param
      phone_param = normalize_phone
      return phone_param if phone_param.is_a?(Hash) && phone_param.key?(:errors)

      # course_param_id
      course_param_id = normalize_course_param_id
      return course_param_id if course_param_id.is_a?(Hash) && course_param_id.key?(:errors)

      # country_param_id
      country_param_id = normalize_country_param_id
      return country_param_id if country_param_id.is_a?(Hash) && country_param_id.key?(:errors)

      # create the application
      created_application = Application.create!(
        first_name: first_name_param,
        last_name: last_name_param,
        email: email_param,
        phone: phone_param,
        course_id: course_param_id,
        country_id: country_param_id
      )
      ApplicationNotificationMailer.new_application_email(created_application).deliver_now
      created_application.update(email_sent: true)
      ApplicationNotificationMailer.notify_admin(created_application).deliver_now

      # convert application User and student
      conversion_result = ApplicationToUserService.new(created_application).convert_to_user_and_student
      if conversion_result[:success]
        { success: true, info: { application: created_application, user: conversion_result[:user], student: conversion_result[:student]}}
      else
        { success: false, errors: conversion_result[:errors]}
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    { success: false, errors: e.record.errors.full_messages }
  rescue StandardError => e
    { success: false, errors: [e.message] }
  end

  # view single_appplication
  def single_application
    Application.transaction do
      appl = single_application_search(@applications, @target_param)
      if appl.is_a?(Hash) && appl.key?(:errors)
        return { success: false, errors: appl[:errors] }
      else
        { success: true, info: appl}
      end
    end
  rescue StandardError => e
    { success: false, errors: [e.message]}
  end

  # view all_applications
  def all_applications
    all_apps = @applications
    if all_apps.empty?
      return { success: false, errors: "Empty List!"}
    else
      { success: true, info: all_apps}
    end
  end

  # update_application
  def update_application
    result = nil

    # initialize a transaction
    ActiveRecord::Base.transaction do

      updated_application_params = {}

      @appl = single_application_search(@applications, @target_param)
      if @appl.is_a?(Hash) && @appl.key?(:errors)
        return { success: false, errors: @appl[:errors]}
      end

      # first_name_param
      first_name_param = normalize_update_first_name
      updated_application_params[:first_name] = first_name_param

      # last_name_param
      last_name_param = normalize_update_last_name
      updated_application_params[:last_name] = last_name_param

      # email_param
      email_param = normalize_update_email
      if email_param.is_a?(Hash) && email_param.key?(:errors)
        result = { success: false, errors: email_param[:errors]}
        raise ActiveRecord::Rollback
      end
      updated_application_params[:email] = email_param

      # phone_param
      phone_param = normalize_update_phone
      if phone_param.is_a?(Hash) && phone_param.key?(:errors)
        result = { success: false, errors: phone_param[:errors]}
        raise ActiveRecord::Rollback
      end
      updated_application_params[:phone] = phone_param

      # country_param
      country_param = normalize_update_country
      if country_param.is_a?(Hash) && country_param.key?(:errors)
        result = { success: false, errors: country_param[:errors]}
        raise ActiveRecord::Rollback
      end
      updated_application_params[:country_id] = country_param

      # course_param
      course_param = normalize_update_course
      if course_param.is_a?(Hash) && course_param.key?(:errors)
        result = { success: false, errors: course_param[:errors]}
        raise ActiveRecord::Rollback
      end
      updated_application_params[:course_id] = course_param

      puts "DEBUG: See what passes in the body: #{updated_application_params}"

      @appl.update!(updated_application_params)
      # sync user and student after update
      conversion_result = ApplicationToUserService.new(@appl).update_user_and_student
      if conversion_result[:success]
        result = { success: true, info: { application: @appl, user: conversion_result[:user], student: conversion_result[:student]}}
      else
        result = { success: false, errors: conversion_result[:errors]}
        raise ActiveRecord::Rollback
      end
    end
    result
  rescue ActiveRecord::RecordInvalid => e
    { success: false, errors: e.record.errors.full_messages }
  rescue StandardError => e
    { success: false, errors: [e.message] }
  end

  # delete_application
  def delete_application
    @appl = single_application_search(@applications, @target_param)
    if @appl.is_a?(Hash) && @appl.key?(:errors)
      return { success: false, errors: @appl[:errors]}
    end

    appl_slug = @appl.slug
    appl_delete = @appl.soft_delete
    if appl_delete
      conversion_result = ApplicationToUserService.new(@appl).soft_delete_user_and_student
      if conversion_result[:success]
        { success: true, message: "Application '#{appl_slug}' and linked user/student soft deleted successfully!" }
      else
        { success: false, errors: conversion_result[:errors] }
      end
    else
      { success: false, errors: @appl.errors.full_messages }
    end
  end

  # restore_application
  def restore_application
    @appl = Application.unscoped.find_by(slug: @target_param)

    puts "DEBUG: Target param is #{@target_param}"

    return { success: false, errors: { application: "Application not found!"}} if @appl.nil?

    return { success: false, errors: { application: "Application is not deleted!"}} unless @appl.application_deleted?

    if @appl.restore_application
      conversion_result = ApplicationToUserService.new(@appl).restore_user_and_student
      if conversion_result[:success]
        { success: true, message: "Application '#{@appl.slug}' and linked user/student restored successfully!" }
      else
        { success: false, errors: conversion_result[:errors] }
      end
    else
      { success: false, errors: @appl.errors.full_messages }
    end
  end

  private

  # normalize_update_first_name
  def normalize_update_first_name
    first_name = @params[:first_name].to_s.gsub(/\s+/, '').downcase
    if first_name.present?
      first_name.to_s.titleize
    end
  end

  # normalize_update_last_name
  def normalize_update_last_name
    last_name = @params[:last_name].to_s.gsub(/\s+/, '').downcase
    if last_name.present?
      last_name.to_s.titleize
    end
  end

  # normalize_update_email
  def normalize_update_email
    email = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email.present?

      normalized = normalized_email(email)
      return normalized if normalized.is_a?(Hash) && normalized.key?(:errors)

      # should not be existing
      existing = application_email_search(@applications, normalized, @appl.id)
      return existing if existing.is_a?(Hash) && existing.key?(:errors)

      normalized
    end
  end

  # normalize_phone_param
  def normalize_update_phone
    phone = @params[:phone].to_s.gsub(/\s+/, '')

    if phone.present?
      normalized = normalized_phone(phone)
      return normalized if normalized.is_a?(Hash) && normalized.key?(:errors)
    end

    # should not be existing
    existing = application_phone_search(@applications, normalized, @appl.id)
    return existing if existing.is_a?(Hash) && existing.key?(:errors)

    normalized
  end

  # normalize_update_country
  def normalize_update_country
    country_id = @params[:country_id].to_i
    if country_id.present?
      # check if country exists
      existing = application_country_id_search(@countrys, country_id)
      return existing if existing.is_a?(Hash) && existing.key?(:errors)

      existing
    end
  end

  # normalize_update_course
  def normalize_update_course
    course_id = @params[:course_id].to_i
    if course_id.present?
      # check if course exists
      existing = application_course_id_search(@courses, course_id)
      return existing if existing.is_a?(Hash) && existing.key?(:errors)

      existing
    end
  end

  # normalize_first_name
  def normalize_first_name
    # first_name
    first_name = @params[:first_name].to_s.gsub(/\s+/, '').downcase
    if first_name.blank?
      return { errors: { first_name: "Please input first name!"}}
    end
    first_name.to_s.titleize
  end

  # normalize_last_name
  def normalize_last_name
    # last_name
    last_name = @params[:last_name].to_s.gsub(/\s+/, '').downcase
    if last_name.blank?
      return { errors: { last_name: "Please input last name!"}}
    end
    last_name.to_s.titleize
  end

  # normalize_email
  def normalize_email
    # email
    email = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email.blank?
      return  {errors: { email: "Please input email!"}}
    end

    # email_format
    email_format = normalized_email(email)
    if email_format.is_a?(Hash) && email_format.key?(:errors)
      return email_format
    end

    # email should not exist
    existing = student_email_search(@students, email)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    email.to_s.gsub(/\s+/, '').downcase
  end

  # normalize_phone
  def normalize_phone
    # phone
    phone = @params[:phone].to_s.gsub(/\s+/, '')
    if phone.blank?
      return { errors: { phone: "Please input phone!"}}
    end

    # phone_format
    phone_format = normalized_phone(phone)
    if phone_format.is_a?(Hash) && phone_format.key?(:errors)
      return phone_format
    end

    # phone should not exist
    existing = student_phone_search(@students, phone)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    phone_format
  end

  # normalize_course_param_id
  def normalize_course_param_id
    # course_id
    course_id = @params[:course_id]
    if course_id.blank?
      return { errors: { course_id: "Please select course!"}}
    end

    # check whether course exists
    existing = course_id_search(@courses, course_id)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    course_id
  end

  # normalize_country_param_id
  def normalize_country_param_id
    # country_id
    country_id = @params[:country_id]
    if country_id.blank?
      return { errors: { country_id: "Please select country!"}}
    end

    # check whehter country exists
    existing = country_id_search(@countrys, country_id)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    country_id
  end
end