class User < ApplicationRecord

  has_one :student

  # Hide soft-deleted users bt default
  default_scope { where(deleted_at: nil)}

  # soft delete: just set deleted_at
  def soft_delete
    update(deleted_at: Time.current)
  end

  # check if user is deleted
  def deleted?
    deleted_at.present?
  end

  # Restore a soft-deleted user
  def restore
    update(deleted_at: nil)
  end
  # secure_password
  has_secure_password

  # password_reset
  def generate_password_reset_token!
    token = SecureRandom.urlsafe_base64
    update!(
      reset_password_token: token,
      reset_password_sent_at: Time.current
    )
    token
  end

  def password_token_valid?
    reset_password_sent_at > 2.hours.ago
  end

  def reset_password!(new_password, new_confirmation_password)
    update!(
      reset_password_token: nil,
      password: new_password,
      password_confirmation: new_confirmation_password
    )
  end

  before_save :set_slug

  # validations
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true

  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :flag, presence: true

  private
  def set_slug
    if email.present?
      username = email.split('@').first
      self.slug = username.parameterize
    end
  end
end
