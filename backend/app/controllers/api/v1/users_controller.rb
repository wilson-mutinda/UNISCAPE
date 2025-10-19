class Api::V1::UsersController < ApplicationController

  include SearchHelper
  include RegexHelper
  include SortHelper

  # create_user
  def create_user
    begin
      users = User.all.order(:id).to_a
      # ---------------- EMAIL ------------------------
      email_param = user_params[:email].to_s.gsub(/\s+/, '').downcase
      if email_param.blank?
        render json: { errors: { email: "Please input email!"}}, status: :unprocessable_entity
        return
      end

      # email_format
      normalized_email = normalized_email(email_param)
      if normalized_email.is_a?(Hash)
        render json: normalized_email, status: :unprocessable_entity
        return
      end

      # email should not exist
      existing_email = user_email_search(users, normalized_email)
      if existing_email.is_a?(Hash)
        render json: existing_email, status: :unprocessable_entity
        return
      end
      email_param = normalized_email

      # ----------------------- PHONE -----------------
      phone_param = user_params[:phone].to_s.gsub(/\s+/, '')
      if phone_param.blank?
        render json: { errors: { phone: "Please input phone number!"}}, status: :unprocessable_entity
        return
      end

      # phone_format
      normalized_phone = normalized_phone(phone_param)
      if normalized_phone .is_a?(Hash)
        render json: normalized_phone, status: :unprocessable_entity
        return
      end

      # phone should not exist
      existing_phone = user_phone_search(users, normalized_phone)
      if existing_phone.is_a?(Hash)
        render json: existing_phone, status: :unprocessable_entity
        return
      end

      phone_param = normalized_phone

      # -------------------------- PASSWORD AND PASSWORD_CONFIRMATION ----------------------
      password_param = user_params[:password]
      password_confirmation_param = user_params[:password_confirmation]

      normalized_password = normalized_password(password_param, password_confirmation_param)
      
      if normalized_password.is_a?(Hash) && normalized_password.key?(:errors)
        # handle error case
        render json: normalized_password, status: :unprocessable_entity
        return
      else
        # handle success case
        password_param = normalized_password[:password]
        password_confirmation_param = normalized_password[:password_confirmation]
      end

      # create_user
      created_user = User.create(
        email: email_param,
        phone: phone_param,
        password: password_param,
        password_confirmation: password_confirmation_param,
        flag: 'Admin'
      )

      if created_user
        render json: { message: "User created!"}, status: :created
      else
        render json: { error: "Error creating user!", info: created_user.errors.full_messages }, status: :unprocessable_entity
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

      # empty list to hold updated_user_params
      updated_user_params = {}

      users = User.all.order(:email).to_a
      target_param = params[:slug]

      user = user_slug_search(users, target_param)

      if user.is_a?(Hash) && user[:errors].present?
        render json: user, status: :unprocessable_entity
        return
      end

      # email_param
      email_param = user_params[:email].to_s.strip.downcase
      if email_param.present?
        # email_format
        normalized_email = normalized_email(email_param)
        if normalized_email.is_a?(Hash)
          render json: normalized_email, status: :unprocessable_entity
          return
        end

        # email should not exist
        existing_email = unique_email_search(users, normalized_email, user.id)
        if existing_email.is_a?(Hash)
          render json: existing_email, status: :unprocessable_entity
          return
        end
        
        updated_user_params[:email] = email_param
      end

      # phone_param
      phone_param = user_params[:phone].to_s.gsub(/\s+/, '')
      if phone_param.present?
        # phone_format
        normalized_phone = normalized_phone(phone_param)
        if normalized_phone.is_a?(Hash)
          render json: normalized_phone, status: :unprocessable_entity
          return
        end

        # phone should not exist
        existing_phone = unique_phone_search(users, normalized_phone, user.id)
        if existing_phone.is_a?(Hash)
          render json: existing_phone, status: :unprocessable_entity
          return
        end

        updated_user_params[:phone] = phone_param
      end

      # password_param and password_confirmation_param
      password_param = user_params[:password]
      password_confirmation_param = user_params[:password_confirmation]

      normalized_password = normalized_password(password_param, password_confirmation_param)
      if normalized_password.is_a?(Hash) && normalized_password.key?(:errors)
        render json: normalized_password, status: :unprocessable_entity
        return
      end
    
      updated_user_params[:password] = normalized_password[:password]
      updated_user_params[:password_confirmation] = normalized_password[:password_confirmation]

      # update_user
      updated_user = user.update(updated_user_params)
      if updated_user
        render json: { message: "User updated!"}, status: :ok
      else
        render json: { error: "Error updating user!", info: updated_user.errors.full_messages }, status: :unprocessable_entity
        return
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
      delete_info = user.destroy
      if delete_info
        render json: { message: "User wtih '#{user_email}' deleted successfully!"}, status: :ok
      else
        render json: { error: "Error deleting user!", info: delete_info.errors.full_messages }, status: :unprocessable_entity
        return
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
