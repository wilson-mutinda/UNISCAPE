class ApplicationService

  include RegexHelper
  include SearchHelper

  def initialize(params = {})
    @params = params || {}
    @students = Application.all.order(:email).to_a
    @courses = Course.all.order(:course_name).to_a
    @countrys = Country.all.order(:name).to_a
  end

  # create_application
  def create_application
    # first_name_param
    first_name_param = normalize_first_name
    if first_name_param.is_a?(Hash) && first_name_param.key?(:errors)
      return first_name_param
    end

    # last_name_param
    last_name_param = normalize_last_name
    if last_name_param.is_a?(Hash) && last_name_param.key?(:errors)
      return last_name_param
    end

    # email_param
    email_param = normalize_email
    if email_param.is_a?(Hash) && email_param.key?(:errors)
      return email_param
    end

    # phone_param
    phone_param = normalize_phone
    if phone_param.is_a?(Hash) && phone_param.key?(:errors)
      return phone_param
    end

    # course_param_id
    course_param_id = normalize_course_param_id
    if course_param_id.is_a?(Hash) && course_param_id.key?(:errors)
      return course_param_id
    end

    # country_param_id
    country_param_id = normalize_country_param_id
    if country_param_id.is_a?(Hash) && country_param_id.key?(:errors)
      return country_param_id
    end

    # create_application
    created_application = Application.create(
      first_name: first_name_param,
      last_name: last_name_param,
      email: email_param,
      phone: phone_param,
      course_id: course_param_id,
      country_id: country_param_id
    )
    if created_application.persisted?
      { success: true, info: created_application }
    else
      { success: false, errors: created_application.errors.full_messages }
    end
  end

  # view single_appplication
  def single_appplication
    appl
  end

  private

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