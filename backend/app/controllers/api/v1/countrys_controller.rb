class Api::V1::CountrysController < ApplicationController

  # create_country
  def create_country
    begin
      service = CountryService.new(country_params)
      result = service.create_country

      if result[:success]
        render json: result[:message], status: :created
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_country
  def single_country
    begin
      service = CountryService.new(country_params.merge(slug: params[:slug]))
      result = service.single_country

      if result[:success]
        course = result[:country_info].as_json(except: [:created_at, :updated_at])
        render json: course, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_countrys
  def all_countrys
    begin
      service = CountryService.new(country_params.merge(slug: params[:slug]))
      result = service.all_countrys

      if result[:success]
        countrys = result[:countrys].map do |country|
          country.as_json(except: [:created_at, :updated_at])
        end
        render json: countrys, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_country
  def update_country
    begin
      service = CountryService.new(country_params.merge(slug: params[:slug]))
      result = service.update_country

      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_country
  def delete_country
    begin
      service = CountryService.new(country_params.merge(slug: params[:slug]))
      result = service.delete_country

      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_country
  def restore_country
    begin
      service = CountryService.new(country_params.merge(slug: params[:slug]))
      result = service.restore_country

      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold country_params
  private
  def country_params
    params.require(:country).permit(:name)
  end
end
