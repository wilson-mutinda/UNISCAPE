class User < ApplicationRecord
  
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

  before_save :set_slug

  # validations
  validates :email, presence: true, uniqueness: true, if: -> { new_record? || email.present? }
  validates :phone, presence: true, uniqueness: true, if: -> { new_record? || phone.present? }
  validates :password, presence: true, confirmation: true, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true, if: -> { new_record? || password.present? }
  validates :flag, presence: true, if: -> { new_record? || flag.present? }

  private
  def set_slug
    if slug.blank? && email.present?
      username = email.split('@').first
      self.slug = username.parameterize
    end
  end
end
