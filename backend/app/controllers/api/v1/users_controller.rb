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

      # -------------------------- PASSWORD AND PASSWORD CONFIRMATION ----------------------

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
