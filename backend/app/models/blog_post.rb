class BlogPost < ApplicationRecord
  belongs_to :user

  before_create :generate_slug

  validates :title, :excerpt, :content, presence: true
  validates :slug, uniqueness: true

  private
  def generate_slug
    if title.present?
      self.slug = title.parameterize
    end
  end
end
