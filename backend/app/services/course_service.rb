class CourseService

  include SortHelper
  include SearchHelper
  include RegexHelper

  def initialize(params = {})
    @params = params || {}
    @courses = Course.all.order(:course_name).to_a
    @target_param = params[:slug]
  end

  # create_course
  def create_course

    course_name_param = normalize_course_name
    if course_name_param.is_a?(Hash)
      return course_name_param
    end

    course_duration_param = normalize_course_duration
    if course_duration_param.is_a?(Hash)
      return course_duration_param
    end

    course_fee_param = normalize_course_fee
    if course_fee_param.is_a?(Hash)
      return course_fee_param
    end

    course_desc_param = normalize_course_desc
    if course_desc_param.is_a?(Hash)
      return course_desc_param
    end

    course_more_info_param = normalize_course_more_info
    if course_more_info_param.is_a?(Hash)
      return course_more_info_param
    end

    # create_course
    created_course = Course.create(
      course_name: course_name_param,
      course_duration: course_duration_param,
      course_fee: course_fee_param,
      course_desc: course_desc_param,
      course_more_info: course_more_info_param
    )

    if @params[:course_image].present?
      created_course.course_image.attach(@params[:course_image])
    end

    if @params[:course_flyer].present?
      created_course.course_flyer.attach(@params[:course_flyer])
    end

    if created_course
      { success: true, message: "Course '#{course_name_param}' created successfully!"}
    else
      { success: false, errors: created_course.errors.full_messages }
    end

  end

  # view single_course
  def single_course
    @course = course_slug_search(@courses, @target_param)
    if @course.is_a?(Hash) && @course.key?(:errors)
      return @course
    end

    info = @course
    if info
      { success: true, course_info: @course }
    else
      { success: false, errors: @course.errors.full_messages }
    end
  end

  # view all_courses
  def all_courses
    @sorted_courses = course_name_sort(@courses)
    if @sorted_courses.empty?
      { success: false, errors: "Empty List!"}
    else
      { success: true, courses: @sorted_courses }
    end
  end

  def update_course
    @course = course_slug_search(@courses, @target_param)
    if @course.is_a?(Hash) && @course.key?(:errors)
      return @course
    end

    updated_course_params = {}
    has_updates = false

    # course_name_param - check if param exists in request (not just if present)
    if @params.key?(:course_name)
      course_name_param = normalized_update_course_name
      return course_name_param if course_name_param.is_a?(Hash)
      updated_course_params[:course_name] = course_name_param
      has_updates = true
    end

    # course_duration_param
    if @params.key?(:course_duration)
      course_duration_param = normalized_update_course_duration
      updated_course_params[:course_duration] = course_duration_param
      has_updates = true
    end

    # course_fee_param
    if @params.key?(:course_fee)
      course_fee_param = normalized_update_course_fee
      updated_course_params[:course_fee] = course_fee_param
      has_updates = true
    end

    # course_desc_param
    if @params.key?(:course_desc)
      course_desc_param = normalized_update_course_desc
      updated_course_params[:course_desc] = course_desc_param
      has_updates = true
    end

    # course_more_info_param
    if @params.key?(:course_more_info)
      course_more_info_param = normalized_update_course_more_info
      updated_course_params[:course_more_info] = course_more_info_param
      has_updates = true
    end

    # course_image_param - handle file uploads separately if needed
    if @params.key?(:course_image)
      course_image_param = normalized_update_course_image
      updated_course_params[:course_image] = course_image_param
      has_updates = true
    end

    # course_flyer_param - handle file uploads separately if needed
    if @params.key?(:course_flyer)
      course_flyer_param = normalized_update_course_flyer
      updated_course_params[:course_flyer] = course_flyer_param
      has_updates = true
    end

    return { success: false, errors: "No valid update parameters provided!" } unless has_updates

    # update_course
    updated_course = @course.update(updated_course_params)
    if updated_course
      puts "DEBUG: See what's being updated: #{updated_course_params}"
      { success: true, message: "Course updated successfully!"}
    else
      { success: false, errors: @course.errors.full_messages }
    end
  end

  # delete_course
  def delete_course

    @course = course_slug_search(@courses, @target_param)
    if @course.is_a?(Hash) && @course.key?(:errors)
      return @course
    end

    # soft_delete course
    course_name = @course.course_name
    course_delete = @course.soft_delete
    if course_delete
      { success: true, message: "Course '#{course_name}' soft deleted successfully!"}
    else
      { success: false, errors: @course.errors.full_messages }
    end
  end

  # restore_course
  def restore_course
    @course = Course.unscoped.find_by(slug: @target_param)

    if @course.nil?
      return { success: false, errors: { course: "Course not found!"}}
    end

    unless @course.deleted?
      return { success: false, errors: { course: "Course is not deleted!"}}
    end

    restored_course = @course.restore
    if restored_course
      { success: true, message: "Course '#{@course.course_name}' restored successfully!"}
    else
      { success: false, errors: @course.errors.full_messages }
    end
  end

  private
  # normalized_update_course_name
  def normalized_update_course_name
    # course_name
     course_name = @params[:course_name].to_s.downcase
     if course_name.present?
      # course_name should not exist
      existing = course_name_search(@courses, course_name, @course.id)
      if existing.is_a?(Hash) && existing.key?(:errors)
        return existing
      end
      course_name.titleize
     end
  end

  # normalized_update_course_duration
  def normalized_update_course_duration
    # course_duration
    course_duration = @params[:course_duration].to_s.downcase
    if course_duration.present?
      course_duration.titleize
    end
  end

  # normalized_update_course_fee
  def normalized_update_course_fee
    # course_fee
    course_fee = @params[:course_fee].to_s
    if course_fee.present?
      course_fee
    end
  end

  # normalized_update_course_desc
  def normalized_update_course_desc
    # course_desc
    course_desc = @params[:course_desc].to_s
    if course_desc.present?
      course_desc
    end
  end

  # normalized_update_course_more_info
  def normalized_update_course_more_info
    # course_more_info
    course_more_info = @params[:course_more_info].to_s
    if course_more_info.present?
      course_more_info
    end
  end

  # normalized_update_course_image
  def normalized_update_course_image
    # course_image
    course_image = @params[:course_image]
    if course_image.present?
      course_image
    end
  end

  # normalized_update_course_flyer
  def normalized_update_course_flyer
    # course_flyer
    course_flyer = @params[:course_flyer]
    if course_flyer.present?
      course_flyer
    end
  end

  # normalize_course_name
  def normalize_course_name
    # course_name
    course_name = @params[:course_name].to_s.downcase

    if course_name.blank?
      return { errors: { course_name: "Please input course name!"}}
    end

    # course name should not exist
    existing = unique_course_name(@courses, course_name)
    if existing.is_a?(Hash) && existing.key?(:errors)
      return existing
    end
    course_name.to_s.titleize
  end

  # normalize_course_duration
  def normalize_course_duration
    # course_duration
    course_duration = @params[:course_duration].to_s

    if course_duration.blank?
      return { errors: { course_duration: "Please input course duration!"}}
    end

    course_duration.to_s.titleize
  end

  # normalize_course_fee
  def normalize_course_fee
    # course_fee
    course_fee = @params[:course_fee].to_s

    if course_fee.blank?
      return { errors: { course_fee: "Please input course fee!"}}
    end

    course_fee
  end

  # normalize_course_desc
  def normalize_course_desc
    course_desc = @params[:course_desc].to_s

    if course_desc.blank?
      return { errors: { course_desc: "Please input course description!"}}
    end

    course_desc
  end

  # normalize_course_more_info
  def normalize_course_more_info
    course_more_info = @params[:course_more_info].to_s

    if course_more_info.blank?
      return { errors: { course_more_info: "Please input more info!"}}
    end

    course_more_info
  end

end