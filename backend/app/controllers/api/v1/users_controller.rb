class Api::V1::UsersController < ApplicationController

  include SearchHelper
  include RegexHelper
  include SortHelper

  # create_user
  def create_user
    begin
      service = UserService.new(user_params)
      result = service.create_user

      if result[:success]
        render json: { message: "User created"}, status: :created
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end

    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_user
  def single_user
    begin
      service = UserService.new(params.merge(slug: params[:slug]))
      result = service.single_user
      if result[:success]
        render json: result[:user_info], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_users
  def all_users
    begin
      service = UserService.new(params)
      result = service.all_users
      if result[:success]
        render json: result[:info], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_user
  def update_user
    begin

      service = UserService.new(user_params.merge(slug: params[:slug]))
      result = service.update_user
      if result[:success]
        render json: { message: "User updated successfully!"}, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_user
  def delete_user
    begin
      service = UserService.new(user_params.merge(slug: params[:slug]))
      result = service.delete_user
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_user
  def restore_user
    begin
      service = UserService.new(params.merge(slug: params[:slug]))
      result = service.restore_user
      if result[:success]
        render json: { message: result[:message]}, status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # user_login
  def user_login
    begin
      service = UserService.new(params)
      result = service.user_login
      if result[:success]
        user_info = result[:user].as_json(except: [:created_at, :updated_at, :password_digest, :deleted_at])
        render json: { message: result[:message], user: user_info}, status: :ok
      else
        render json: { errors: result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold user_params
  private
  def user_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation, :flag)
  end
end
