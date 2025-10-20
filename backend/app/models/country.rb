class Country < ApplicationRecord
  before_save :generate_slug

  # hide soft-deleted countrys by default
  default_scope { where(deleted_at: nil)}

  # soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  # check if country is deleted
  def deleted?
    deleted_at.present?
  end

  # restore a soft-deleted user
  def restore
    update(deleted_at: nil)
  end

  # validations
  validates :name, presence: true, uniqueness: true, if: -> { new_record? || name.present? }
  validates :slug, uniqueness: true

  private
  def generate_slug
    if name.present?
      self.slug = name.parameterize
    end
  end
end
