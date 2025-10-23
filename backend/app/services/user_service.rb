require_relative 'json_web_token_service'

class UserService

  include RegexHelper
  include SearchHelper
  include SortHelper

  def initialize(params)
    @params = params
    @users = User.all.order(:email).to_a
    @target_param = params[:slug]
  end

  # create_user
  def create_user
    email_param = normalize_email
    if email_param.is_a?(Hash)
      return email_param
    end

    phone_param = normalize_phone
    if phone_param.is_a?(Hash)
      return phone_param
    end

    password_data = normalize_password
    if password_data.is_a?(Hash) && password_data.key?(:errors)
      return password_data
    end

    # create_user
    user = User.create(
      email: email_param,
      phone: phone_param,
      password: password_data[:password],
      password_confirmation: password_data[:password_confirmation],
      flag: @params[:flag] || 'Admin'
    )
    if user
      { success: true, user: user}
    else
      { success: false, errors: user.errors.full_messages }
    end
  end

  # view single_user
  def single_user
    @user = user_slug_search(@users, @target_param)
    if @user.is_a?(Hash) && @user.key?(:errors)
      return @user
    end

    info = @user
    if info
      { success: true, user_info: info.as_json(except: [:created_at, :updated_at, :password_digest])}
    else
      { success: false, errors: info.errors.full_messages }
    end
  end
  # view all_users
  def all_users
    @sorted_users = user_email_sort(@users)
    if @sorted_users.empty?
      { success: false, errors: "Empty List!"}
    else
      { success: true, info: @sorted_users.map do |user|
        user.as_json(except: [:created_at, :updated_at, :password_digest])
      end }
    end
  end

  # update_user
  def update_user

    updated_user_params = {}

    @user = user_slug_search(@users, @target_param)

    if @user.is_a?(Hash) && @user[:errors]
      return @user
    end

    email_param = normalize_update_email
    if email_param.is_a?(Hash)
      return email_param
    end
    updated_user_params[:email] = email_param

    phone_param = normalize_update_phone
    if phone_param.is_a?(Hash)
      return phone_param
    end
    updated_user_params[:phone] = phone_param

    password_data = normalize_password
    if password_data.is_a?(Hash) && password_data.key(:errors)
      return password_data
    end
    updated_user_params[:password] = password_data[:password]
    updated_user_params[:password_confirmation] = password_data[:password_confirmation]

    # update_user
    updated_user = @user.update(updated_user_params)
    if updated_user
      { success: true, user: @user }
    else
      { success: false, errors: @user.errors.full_messages }
    end
  end

  # delete_user
  def delete_user
    @user = user_slug_search(@users, @target_param)
    if @user.is_a?(Hash) && @user.key?(:errors)
      return @user
    end

    user_email = @user.email
    user_delete = @user.soft_delete
    if user_delete
      { success: true, message: "User with '#{user_email}' deleted successfully!"}
    else
      { success: false, errors: @user.errors.full_messages }
    end
  end

  # restore_user
  def restore_user
    @user = User.unscoped.find_by(slug: @target_param)

    if @user.nil?
      return { success: false, errors: { user: "User not found!"}}
    end

    # only restore if soft-deleted, otherwise skip
    if !@user.deleted?
      puts "DEBUG: USer '#{@user.email}' is already active - no need to restore."
      return  {success: true, message: "User '#{@user.email}' is already active!"}
    end

    if @user.restore
      { success: true, message: "User '#{@user.email}' restored successfully!"}
    else
      { success: false, errors: @user.errors.full_messages }
    end
  end

  # user_login
  def user_login
    # email_param
    email_param = normalize_login_email
    if email_param.is_a?(Hash) && email_param.key?(:errors)
      return email_param
    end
    
    # password_param
    password_param = normalize_login_password
    if password_param.is_a?(Hash) && password_param.key?(:errors)
      return password_param
    end

    user = User.find_by(email: email_param)
    puts "DEBUG: Find the user: #{user}"
    if user
      # authentication
      auth = user.authenticate(password_param)
      if auth
        token = JsonWebToken.new
        access_token = token.encode_token(user.id, user.flag, 30.minutes.from_now)
        refresh_token = token.encode_token(user.id, user.flag, 24.hours.from_now)
        { success: true, message: "Login Successful!", user: user, access_token: access_token, refresh_token: refresh_token }
      else
        { success: false, errors: auth.errors.full_messages }
      end
    end
  end

  private
  # normalize_email
  def normalize_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.blank?
      return { errors: { email: "Please input email!"}}
    end

    # email_format
    normalized = normalized_email(email_param)
    if normalized.is_a?(Hash)
      return normalized
    end

    # email should not exist
    existing = user_email_search(@users, normalized)
    if existing.is_a?(Hash)
      return existing
    end

    normalized
  end

  # normalize_phone
  def normalize_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.blank?
      return { errors: { phone: "Please input phone number!"}}
    end

    # phone_format
    normalized = normalized_phone(phone_param)
    if normalized.is_a?(Hash)
      return normalized
    end

    # phone should not exist
    existing = user_phone_search(@users, normalized)
    if existing.is_a?(Hash)
      return existing
    end

    normalized
  end

  # normalize_update_email
  def normalize_update_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase
    if email_param.present?

      # email_format
      normalized = normalized_email(email_param)
      if normalized.is_a?(Hash)
        return normalized
      end

      # email should not exist
      existing = unique_email_search(@users, normalized, @user.id)
      if existing.is_a?(Hash)
        return existing
      end
    end
    normalized
  end

  # normalize_update_phone
  def normalize_update_phone
    phone_param = @params[:phone].to_s.gsub(/\s+/, '')
    if phone_param.present?

      # phone_format
      normalized = normalized_phone(phone_param)
      if normalized.is_a?(Hash)
        return normalized
      end

      # phone should not exist
      existing = unique_phone_search(@users, normalized, @user.id)
      if existing.is_a?(Hash)
        return existing
      end
    end
    normalized
  end

  # normalize_login_email
  def normalize_login_email
    email_param = @params[:email].to_s.gsub(/\s+/, '').downcase

    if email_param.blank?
      return { errors: { errors: "Please input email"}}
    end

    # check if email is existing
    existing = login_email_search(@users, email_param)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    existing
  end

  def normalize_login_password
    password_param = @params[:password].to_s
    if password_param.blank?
      return { errors: { errors: "Please input password"}}
    end
    password_param
  end

  # normalize_password
  def normalize_password
    normalized_password(@params[:password], @params[:password_confirmation])
  end
end