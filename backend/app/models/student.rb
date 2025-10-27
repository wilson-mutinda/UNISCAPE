class Student < ApplicationRecord

  # hide soft-deleted students by default
  default_scope { where(deleted_at: nil)}

  # soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  # check if student is deleted
  def deleted?
    deleted_at.present?
  end

  # restore a soft deleted_student
  def restore
    update(deleted_at: nil)
  end

  before_create :generate_slug

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
