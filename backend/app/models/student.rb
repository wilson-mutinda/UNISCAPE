class Student < ApplicationRecord

  before_save :generate_slug

  belongs_to :user
  belongs_to :country

  # validations
  validates :first_name, presence: true, if: -> { new_record? || first_name.present? }
  validates :last_name, presence: true, if: -> { new_record? || last_name.present? }

  private
  def generate_slug
    if first_name.present? && last_name.present?
      name = "#{first_name} #{last_name}"
      self.slug = name.parameterize
    end
  end
end
