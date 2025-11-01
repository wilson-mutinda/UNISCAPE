class Category < ApplicationRecord

  # hide soft-deleted categories by default
  default_scope { where(deleted_at:nil)}

  # soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  # check if category is deleted
  def category_deleted?
    deleted_at.present?
  end

  # restore
  def restore
    update(deleted_at: nil)
  end

  before_create :generate_slug

  has_many :courses

  # validates
  validates :name, presence: true, uniqueness: true

  private
  def generate_slug
    if name.present?
      self.slug = name.parameterize
    end
  end
end
