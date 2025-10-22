class StudentService

  include SearchHelper
  include SortHelper

  def initialize(params = {})
    @params = params || {}
    @students = Student.all.order(:first_name).to_a
    @target_param = params[:slug]
  end

  # create_student
  def create_student
    errors = nil

    # Start transaction block
    ActiveRecord::Base.transaction do
      # create_user
      user_service = UserService.new(@params[:user].merge(flag: 'Student'))
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

  # view all_students
  def all_students
    @sorted_students = student_first_name_sort(@students)
    
    if @sorted_students.empty?
      { success: false, errors: "Empty List!"}
    else
      { success: true, students: @sorted_students }
    end
  end

  # update_student
  def update_student
    @student = student_slug_search(@students, @target_param)
    if @student.is_a?(Hash) && @student.key?(:errors)
      return @student
    end

    errors = nil

    # start transaction for atomic update
    ActiveRecord::Base.transaction do
      # --- Update user if provided ---
      if @params[:user].present?
        puts "DEBUG: Updating user with params: #{@params[:user]}"
        user_service = UserService.new(@params[:user].merge(slug: @student.user.slug))
        user_result = user_service.update_user
        puts "DEBUG: User update result: #{user_result}"

        unless user_result[:success]
          errors = user_result[:errors]
          puts "DEBUG: User update failed: #{errors}"
          raise ActiveRecord::Rollback
        end
      end

      # --- Update country if provided ---
      if @params[:country].present?
        puts "DEBUG: Updating country with params: #{@params[:country]}"

        # include soft-deleted countries
        # current_country = Country.unscoped.find_by(id: @student.country_id)
        requested_country_name = @params[:country][:name].downcase.strip

        new_country = Country.find_by("LOWER(name) = ?", requested_country_name)

        new_country ||= Country.create!(name: requested_country_name.titleize)
        puts "DEBUG: Country '#{new_country.name}' created or found."

        # update student with the new cpuntry id
        @student.update!(country_id: new_country.id)
        puts "DEBUG: Student eassigned to country '#{new_country.name}'"
      end  

      # --- Update student name attributes ---
      if @params[:first_name].present? || @params[:last_name].present?
        student_attrs = {}
        student_attrs[:first_name] = normalize_update_first_name if @params[:first_name].present?
        student_attrs[:last_name] = normalize_update_last_name if @params[:last_name].present?

        unless @student.update(student_attrs)
          errors = @student.errors.full_messages
          raise ActiveRecord::Rollback
        end
      end

      # --- Reload associations and return success ---
      @student.reload
      return { success: true, student: @student }
    end

    # --- If transaction rolled back ---
    { success: false, errors: errors || "Student update failed!" }
  end


  # delete_student
  def delete_student
    @student = student_slug_search(@students, @target_param)
    if @student.is_a?(Hash) && @student.key?(:errors)
      return @student
    end

    errors = nil

    # A transaction for an atomic delete
    ActiveRecord::Base.transaction do
      # soft delete associated user
      if @student.user.present? && !@student.user.deleted?
        user_service = UserService.new(slug: @student.user.slug)
        user_result = user_service.delete_user

        unless user_result[:success]
          errors = user_result[:errors]
          raise ActiveRecord::Rollback
        end
      end

      # soft delete student resord
      unless @student.soft_delete
        errors = @student.errors.full_messages
        raise ActiveRecord::Rollback
      end

      # Return success if all soft deletes
      return { success: true, message: "Student deleted successfully!"}
    end

    # if transaction rolled back
    { success: false, errors: errors || "Student soft delete failed!"}
  end

  # restore_student
  def restore_student
    @student = Student.unscoped.find_by(slug: @target_param)
    
    # handle case where student is not found
    unless @student
      return { success: false, errors: "Student not found!" }
    end

    errors = nil

    # transaction to ensure all related records are restored together
    ActiveRecord::Base.transaction do
      # restore associated user
      user = User.unscoped.find_by(id: @student.user_id)

      if user.present? && user.deleted?
        user_service = UserService.new(slug: user.slug)
        user_result = user_service.restore_user

        unless user_result[:success]
          errors = user_result[:errors]
          raise ActiveRecord::Rollback
        end
      end

      # # Restore associated country
      # if @student.country.present? && @student.country.deleted?
      #   country_service = CountryService.new(slug: @student.country.slug)
      #   country_result = country_service.restore_country

      #   unless country_result[:success]
      #     errors = country_result[:errors]
      #     raise ActiveRecord::Rollback
      #   end
      # end

      # Restore associated student record
      unless @student.restore
        errors = @student.errors.full_messages
        raise ActiveRecord::Rollback
      end

      # Return success after full restoration
      return { success: true, message: "Student restored successfully!", student: @student }
    end
    # if rollback happened
    { success: false, errors: errors || "Student restoration failed!"}
  end

  private

  def normalize_update_first_name
    # first_name_param
    first_name_param = @params[:first_name].to_s.strip
    if first_name_param.present?
      first_name_param.to_s.titleize
    end
  end

  def normalize_update_last_name
    # last_name_param
    last_name_param = @params[:last_name].to_s.strip
    if last_name_param.present?
      last_name_param.to_s.titleize
    end
  end
  
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