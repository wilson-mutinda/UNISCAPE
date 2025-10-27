class Api::V1::ContactsController < ApplicationController

  # create_contact
  def create_contact
    begin
      service = ContactService.new(contact_params)
      result = service.create_contact
      if result[:success]
        render json: { info: {
          message: result[:message],
          info: result[:info]
        }}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_contact
  def single_contact
    begin
      service = ContactService.new(contact_params.merge(slug: params[:slug]))
      result = service.single_contact
      if result[:success]
        info = result[:info].as_json(except: [:created_at, :updated_at])
        render json: info, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_contacts
  def all_contacts
    begin
      service = ContactService.new
      result = service.all_contacts
      if result[:success]
        info = result[:info].map do |contact|
          contact.as_json(except: [:created_at, :updated_at])
        end
        render json: info, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_contact
  def update_contact
    begin
      service = ContactService.new(contact_params.merge({ slug: params[:slug]}))
      result = service.update_contact
      if result[:success]
        render json: { info: {
          message: result[:message],
          info: result[:info]
        }}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_contact
  def delete_contact
    begin
      service = ContactService.new(contact_params.merge(slug: params[:slug]))
      result = service.delete_contact
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_contact
  def restore_contact
    begin
      service = ContactService.new(slug: params[:slug])
      result = service.restore_contact

      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold contact_params
  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
