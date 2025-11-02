class Course < ApplicationRecord

  # hide soft deleted courses by default
  default_scope { where(deleted_at: nil)}

  # soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  # check if course is deleted
  def deleted?
    deleted_at.present?
  end

  # restore a soft deleted course
  def restore
    update(deleted_at: nil)
  end

  before_create :set_slug

  # attach image
  has_one_attached :course_image

  # attach flyer
  has_one_attached :course_flyer

  
  belongs_to :category
  
  # validations
  validates :course_name, presence: true, uniqueness: true, if: -> { new_record? || course_name.present? }
  validates :course_duration, presence: true, if: -> { new_record? || course_duration.present? }
  validates :course_fee, presence: true, if: -> { new_record? || course_fee.present? }
  validates :course_desc, presence: true, if: -> { new_record? || course_desc.present? }
  validates :course_more_info, presence: true, if: -> { new_record? || course_more_info.present? }

  private
  def set_slug
    if course_name.present?
      self.slug = course_name.parameterize
    end
  end

end
