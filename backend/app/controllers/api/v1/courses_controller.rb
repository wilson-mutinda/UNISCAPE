class Api::V1::CoursesController < ApplicationController

  include SearchHelper
  include SortHelper

  # create_course
  def create_course
    begin

      puts "===== DEBUG: Incoming Params ====="
      puts course_params.inspect
      puts "=================================="

      service = CourseService.new(course_params)
      result = service.create_course

      if result[:success]
        render json: result[:message], status: :created
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_course
  def single_course
    begin
      service = CourseService.new(slug: params[:slug])
      result = service.single_course

      if result[:success]
        course_info = result[:course_info]

        image_url = url_for(course_info.course_image) if course_info.course_image.attached?
        flyer_url = url_for(course_info.course_flyer) if course_info.course_flyer.attached?

        render json: course_info.as_json.merge({ course_image: image_url, course_flyer: flyer_url}), status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
  end

  # view all_courses
  def all_courses
    begin
      service = CourseService.new
      result = service.all_courses

      if result[:success]
        courses = result[:courses].map do |course|
          image_url = url_for(course.course_image) if course.course_image.attached?
          flyer_url = url_for(course.course_flyer) if course.course_flyer.attached?
          course.as_json.merge({ course_image: image_url, course_flyer: flyer_url})
        end

        render json: courses, status: :ok

      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_course
  def update_course
    begin
      service = CourseService.new(course_params.merge(slug: params[:slug]))
      result = service.update_course
      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end

    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_course
  def delete_course
    begin
      service = CourseService.new(slug: params[:slug])
      result = service.delete_course

      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # restore_course
  def restore_course
    begin
      service = CourseService.new(slug: params[:slug])
      result = service.restore_course

      if result[:success]
        render json: result[:message], status: :ok
      else
        render json: { errors: result[:errors] || result[:errors]}, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # download_flyer
  def download_flyer
    begin
      course = Course.find_by(slug: params[:slug])

      if course.nil?
        render json: { error: "Course not found!" }, status: :not_found
        return
      end

      unless course.course_flyer.attached?
        render json: { error: "Flyer not attached for this course!" }, status: :not_found
        return
      end

      # custom file name
      ext = course.course_flyer.blob.filename.extension_with_delimiter
      filename = "Uniscape-Technologies-#{course.slug}#{ext}"

      # generate a signed URL for download with a custom filename
      flyer_url = rails_blob_path(
        course.course_flyer.blob,
        disposition: "attachment",
        filename: filename,
        only_path: false
      )

      render json: { download_url: flyer_url, filename: filename  }
    rescue => e
      render json: { error: "Something went wriong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold course_params
  private
  def course_params
    params.require(:course).permit(:course_name, :course_duration, :course_fee, :course_desc, :course_more_info, :course_image, :course_flyer)
  end
end
