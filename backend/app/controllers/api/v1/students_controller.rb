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
