class Api::V1::StudentsController < ApplicationController

  # create_student
  def create_student
    begin
      service = StudentService.new(student_params)
      result = service.create_student

      if result[:success]
        render json: result[:student], status: :created
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_student
  def single_student
    begin
      service = StudentService.new(slug: params[:slug])
      result = service.single_student

      if result[:success]
        render json: result[:student], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_students
  def all_students
    begin
      service = StudentService.new(student_params)
      result = service.all_students

      if result[:success]
        render json: result[:students], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_student
  def update_student
    begin
      service = StudentService.new(student_params.merge(slug: params[:slug]))
      result = service.update_student
      if result[:success]
        render json: { message: "Student updated successfully!", info: result[:student]}, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_student
  def delete_student
    begin
      service = StudentService.new(student_params.merge(slug: params[:slug]))
      result = service.delete_student
      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold student_params
  private
  def student_params
    params.require(:student).permit(
      :user_id, 
      :first_name, 
      :last_name, 
      :country_id,
      user: [:email, :phone, :password, :password_confirmation],
      country: [:name]
      )
  end
end
