class Api::V1::UsersController < ApplicationController

  include SearchHelper
  include RegexHelper

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

  # privately hold user_params
  private
  def user_params
    params.require(:user).permit(:email, :phone, :password, :password_confirmation, :flag)
  end
end
