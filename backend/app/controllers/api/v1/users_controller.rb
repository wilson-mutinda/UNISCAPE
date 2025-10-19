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
      # all_users
      users = User.all.order(:slug).to_a
      target_param = params[:slug]
      info = user_slug_search(users, target_param)

      if info.is_a?(Hash) && info[:errors].present?
        render json: info, status: :unprocessable_entity
        return
      end
      render json: info.as_json(except: [:created_at, :updated_at, :password_digest]), status: :ok
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view all_users
  def all_users
    begin
      users = User.all.order(:email).to_a
      if users.empty?
        render json: { error: "Empty List!"}, status: :not_found
        return
      end

      user_list = user_email_sort(users)
      info = user_list.map do |user|
        user.as_json(except: [:created_at, :updated_at, :password_digest])
      end
      render json: info, status: :ok
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
      users = User.all.order(:email).to_a
      target_param = params[:slug]

      user = user_slug_search(users, target_param)
      if user.is_a?(Hash) && user[:errors]
        render json: user, status: :unprocessable_entity
        return
      end
      user_email = user.email
      if user.soft_delete
        render json: { message: "User with '#{user_email}' spft deleted successfully!"}, status: :ok
      else
        render json: { error: "Error deleting user!", info: user.errors.full_messages }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold user_params
  private
  def user_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation, :flag)
  end
end
