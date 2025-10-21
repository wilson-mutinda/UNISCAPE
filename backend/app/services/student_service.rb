class StudentService

  include SearchHelper

  def initialize(params)
    @params = params
    @students = Student.unscoped.order(:first_name).to_a
    @target_param = params[:slug]
  end

  # create_student
  def create_student
    errors = nil

    # Start transaction block
    ActiveRecord::Base.transaction do
      # create_user
      user_service = UserService.new(@params[:user])
      user_result = user_service.create_user

      unless user_result[:success]
        errors = user_result[:errors]
        raise ActiveRecord::Rollback
      end
      user = user_result[:user]

      # create_country
      country_service = CountryService.new(@params[:country])
      country_result = country_service.create_country

      unless country_result[:success]
        errors = country_result[:errors]
        raise ActiveRecord::Rollback
      end
      country = country_result[:country]

      # Normalize names
      first_name = normalize_first_name
      if first_name.is_a?(Hash) && first_name.key?(:errors)
        errors = first_name[:errors]
        raise ActiveRecord::Rollback
      end

      last_name = normalize_last_name
      if last_name.is_a?(Hash) && last_name.key?(:errors)
        errors = last_name[:errors]
        raise ActiveRecord::Rollback
      end

      # create_student
      student = Student.create(
        first_name: first_name,
        last_name: last_name,
        user: user,
        country: country
      )

      unless student
        errors = student.errors.full_messages
        raise ActiveRecord::Rollback
      end

      # return student if everything works
      return { success: true, student: student }
    end

    # if transaction rolled back
    { success: false, errors: errors || "Student  creation failed!"}

  rescue => e
    # any unexpected exception
    { success: false, errors: e.message }

  end

  # view single_student
  def single_student
    @student = student_slug_search(@students, @target_param)
    if @student.is_a?(Hash) && @student.key?(:errors)
      return @student
    end
    student = @student
    if student
      { success: true, student: student}
    else
      { success: false, errors: @student.errors.full_messages }
    end
  end

  private
  
  def normalize_first_name
    # first_name_param
    first_name_param = @params[:first_name].to_s.strip
    if first_name_param.blank?
      return { errors: { first_name: "Please input first name!"}}
    end
    first_name_param.to_s.titleize
  end

  def normalize_last_name
    # last_name_param
    last_name_param = @params[:last_name].to_s.strip
    if last_name_param.blank?
      return { errors: { last_name: "Please input last name!"}}
    end
    last_name_param.to_s.titleize
  end
end