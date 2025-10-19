class User < ApplicationRecord
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
