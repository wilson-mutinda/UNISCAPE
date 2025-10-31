class Api::V1::CategoriesController < ApplicationController

  # create_category
  def create_category
    begin
      service = CategoryService.new(category_params)
      result = service.create_category
      if result[:success]
        render json: { info: result[:message]}, status: :created
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # single_category
  def single_category
    service = CategoryService.new(slug: params[:slug])
    result = service.single_category

    if result[:success]
      info = result[:category_info].as_json(except: [:created_at, :updated_at])
      render json: info, status: :ok
    else
      render json: { errors: result[:errors]}, status: :unprocessable_entity
    end
  end

  # all_categories
  def all_categories
    service = CategoryService.new
    result = service.all_categories
    if result[:success]
      info = result[:info].map do |category|
        category.as_json(except: [:created_at, :updated_at])
      end
      render json: info, status: :ok
    else
      render json: { errors: result[:errors]}, status: :unprocessable_entity
    end
  end

  # update_category
  def update_category
    begin
      service = CategoryService.new(category_params.merge(slug: params[:slug]))
      result = service.update_category
      if result[:success]
        render json: {
          message: result[:message],
          info: result[:info]
        }, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_category
  def delete_category
    begin
      service = CategoryService.new(slug: params[:slug])
      result = service.delete_category
      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Somethinf went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_category
  def restore_category
    begin
      service = CategoryService.new(slug: params[:slug])
      result = service.restore_category
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold category_params
  private
  def category_params
    params.require(:category).permit(:name)
  end
end
