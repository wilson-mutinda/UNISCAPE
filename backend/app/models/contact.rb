class Contact < ApplicationRecord

  # hide soft deleted contacts by default
  default_scope { where(deleted_at: nil)}

  # soft_delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end

  def restore
    update(deleted_at: nil)
  end

  before_create :generate_slug

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  validates :slug, uniqueness: true

  private
  def generate_slug
    if name.present?
      base_slug = "#{name.parameterize}-contact"
      slug_candidate = base_slug
      
      count = 1;
      while Contact.exists?(slug: slug_candidate)
        slug_candidate = "#{base_slug}-#{count}"
        count += 1
      end
      self.slug = slug_candidate
    end
  end
end
