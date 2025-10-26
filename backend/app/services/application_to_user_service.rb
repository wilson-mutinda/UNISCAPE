class ApplicationToUserService

  def initialize(application)
    @application = application
  end

  def convert_to_user_and_student
    ActiveRecord::Base.transaction do
      # create or find the student
      user = User.find_or_initialize_by(email: @application.email)
      user.phone = @application.phone
      user.flag = "Student"
      user.password_digest = nil
      user.save!(validate: false)

      # createor finf student
      student = Student.find_or_initialize_by(user: user)
      student.first_name = @application.first_name
      student.last_name = @application.last_name
      student.country_id = @application.country_id
      student.save!

      { success: true, user:user, student: student }
    end
  rescue ActiveRecord::RecordInvalid => e
    { success: false, errors: e.record.errors.full_messages }
  end

  # sync (update) existing user and student when application changes
  def update_user_and_student
    ActiveRecord::Base.transaction do
      user = User.find_by(email: @application.email)
      student = Student.find_by(user: user)

      unless user
        # if user misses, fallback to creation
        return convert_to_user_and_student
      end

      # update_user_info
      user.update!(
        phone: @application.phone
      )

      # update student info
      if student
        student.update!(
          first_name: @application.first_name,
          last_name: @application.last_name,
          country_id: @application.country_id
        )
      end

      { success: true, user: user, student: student }
    end
  rescue ActiveRecord::RecordInvalid => e
    { success: false, errors: e.record.errors.full_messages }
  end

  # soft delete linked user and student
  def soft_delete_user_and_student
    ActiveRecord::Base.transaction do
      user = User.find_by(email: @application.email)
      student = Student.find_by(user: user)


      user&.update_columns(deleted_at: Time.current)
      student&.update_columns(deleted_at: Time.current)

      { success: true, message: "User and student soft deleted!" }
    end
  rescue => e
    { success: false, errors: [e.message]}
  end

  # restore linked user and student
  def restore_user_and_student
    ActiveRecord::Base.transaction do
      user = User.unscoped.find_by(email: @application.email)
      student = Student.unscoped.find_by(user:user)

      user&.update_columns(deleted_at: nil)
      student&.update_columns(deleted_at: nil)

      { success: true, message: "User and student restored successfully!" }
    end
  rescue => e
    { success: false, errors: [e.message]}
  end
end