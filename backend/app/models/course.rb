class Course < ApplicationRecord

  # attach image
  has_one_attached :course_image
  
  # validations
  validates :course_name, presence: true, uniqueness: true, if: -> { new_record? || course_name.present? }
  validates :course_duration, presence: true, if: -> { new_record? || course_duration.present? }
  validates :course_fee, presence: true, if: -> { new_record? || course_fee.present? }
  validates :course_desc, presence: true, if: -> { new_record? || course_desc.present? }
  validates :course_more_info, presence: true, if: -> { new_record? || course_more_info.present? }

end
