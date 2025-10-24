class Application < ApplicationRecord
  belongs_to :country
  belongs_to :course

  # validations
  validates :first_name, presence: true, if: -> { new_record? || first_name.present? }
  validates :last_name, presence: true, if: -> { new_record? || last_name.present? }
  validates :email, presence: true, uniqueness: true, if: -> { new_record? || email.present? }
  validates :phone, presence: true, uniqueness: true, if: -> { new_record? || phone.present? }
end
