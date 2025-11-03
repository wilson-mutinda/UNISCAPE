class Api::V1::ApplicationsController < ApplicationController

  # create_application
  def create_application
    begin

      puts ">>> Request format: #{request.format}"
      puts ">>> Request headers: #{request.headers['Content-Type']}"

      service = ApplicationService.new(application_params)
      result = service.create_application
      if result[:success]
        render json: { message: "Application created successfully!", info: result[:info]}, status: :created
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_application
  def single_application
    begin
      service = ApplicationService.new(slug: params[:slug])
      result = service.single_application
      if result[:success]
        appl = result[:info]

        country_name = appl.country.name
        course_name = appl.course.course_name

        appl_json = appl.as_json(except: [:created_at, :updated_at])
        render json: appl_json.merge({ country_name: country_name, course_name: course_name}), status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_application
  def update_application
    begin
      service = ApplicationService.new(application_params.merge({ slug: params[:slug]}))
      result = service.update_application
      if result[:success]
        render json: { message: "Application updated successfully!", info: result[:info]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_applications
  def all_applications
    begin
      service = ApplicationService.new
      result = service.all_applications
      if result[:success]
        appl = result[:info].map do |a|
          country_name = a.country&.name || "Unknown"
          course_name = a.course&.course_name || "Unknown"
          a.as_json(except: [:created_at, :updated_at]).merge({ country_name: country_name, course_name: course_name})
        end
        render json: appl, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_application
  def delete_application
    begin
      service = ApplicationService.new(slug: params[:slug])
      result = service.delete_application
      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_application
  def restore_application
    begin
      service = ApplicationService.new(slug: params[:slug])
      result = service.restore_application
      if result[:success]
        render json: result[:message], status: :ok
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
    params.require(:application).permit(:first_name, :last_name, :email, :phone, :country_id, :course_id, :email_sent)
  end
end
