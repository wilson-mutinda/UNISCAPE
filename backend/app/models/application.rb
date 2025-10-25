class Application < ApplicationRecord
  belongs_to :country
  belongs_to :course

  before_save :generate_slug

  # validations
  validates :first_name, presence: true, if: -> { new_record? || first_name.present? }
  validates :last_name, presence: true, if: -> { new_record? || last_name.present? }
  validates :email, presence: true, uniqueness: true, if: -> { new_record? || email.present? }
  validates :phone, presence: true, uniqueness: true, if: -> { new_record? || phone.present? }

  private
  def generate_slug
    base_slug = "#{first_name}-#{last_name}-#{course.course_name}".parameterize

    # ensure uniqueness
    count = 2;
    unique_slug = base_slug
    while Application.exists?(slug: unique_slug)
      unique_slug = "#{base_slug}-#{count}"
      count += 1
    end
    self.slug = unique_slug
  end
end
