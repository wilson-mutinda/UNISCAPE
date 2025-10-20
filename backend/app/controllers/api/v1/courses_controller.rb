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
      service = CourseService.new(course_params.merge(slug: params[:slug]))
      result = service.single_course

      if result[:success]
        course_info = result[:course_info]

        image_url = url_for(course_info.course_image) if course_info.course_image.attached?

        render json: course_info.as_json.merge({ course_image: image_url}), status: :ok
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
      service = CourseService.new(course_params)
      result = service.all_courses

      if result[:success]
        courses = result[:courses].map do |course|
          image_url = url_for(course.course_image) if course.course_image.attached?
          course.as_json.merge({ course_image: image_url})
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
      service = CourseService.new(course_params.merge(slug: params[:slug]))
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
      service = CourseService.new(course_params.merge(slug: params[:slug]))
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

  # privately hold course_params
  private
  def course_params
    params.require(:course).permit(:course_name, :course_duration, :course_fee, :course_desc, :course_more_info, :course_image)
  end
end
