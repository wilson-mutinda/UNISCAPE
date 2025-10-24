class Api::V1::ApplicationsController < ApplicationController

  # create_application
  def create_application
    begin
      service = ApplicationService.new(application_params)
      result = service.create_application
      if result[:success]
        render json: { message: "Application created successfully!", info: result[:info]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold application_params
  private
  def application_params
    params.require(:application).permit(:first_name, :last_name, :email, :phone, :country_id, :course_id)
  end
end
