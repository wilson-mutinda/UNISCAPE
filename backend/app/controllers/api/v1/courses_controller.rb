class Api::V1::CoursesController < ApplicationController

  include SearchHelper
  include SortHelper

  # create_course
  def create_course
    begin

      puts "===== DEBUG: Incoming Params ====="
      puts course_params.inspect
      puts "=================================="

      #  --------------- COURSE NAME -----------------
      # course_name_param
      course_name_param = course_params[:course_name].to_s.downcase
      if course_name_param.blank?
        render json: { errors: { course_name: "Plese input course name..."}}, status: :unprocessable_entity
        return
      end

      # course_name uniqueness
      courses = Course.all.order(:course_name).to_a

      existing_course_name = unique_course_name(courses, course_name_param)
      if existing_course_name.is_a?(Hash)
        render json: existing_course_name, status: :unprocessable_entity
        return
      end

      course_name_param = course_name_param.titleize

      # ----------------- COURSE DURATION ----------------------
      # course_duration_param
      course_duration_param = course_params[:course_duration].to_s
      if course_duration_param.blank?
        render json: { errors: { course_duration: "Please input course duration!"}}, status: :unprocessable_entity
        return
      end

      course_duration_param = course_duration_param.titleize

      # ------------------- COURSE FEE --------------------------
      # course_fee_param
      course_fee_param = course_params[:course_fee].to_s
      if course_fee_param.blank?
        render json: { errors: { course_fee: "Please input course fees!"}}, status: :unprocessable_entity
        return
      end

      course_fee_param = course_fee_param

      #  -------------------- COURSE DESC --------------------------
      # course_desc_param
      course_desc_param = course_params[:course_desc].to_s
      if course_desc_param.blank?
        render json: { errors: { course_desc: "Please input course desc!"}}, status: :unprocessable_entity
        return
      end

      course_desc_param = course_desc_param

      #  -------------------- COURSE MORE INFO --------------------------
      # course_more_info_param
      course_more_info_param = course_params[:course_more_info].to_s
      if course_more_info_param.blank?
        render json: { errors: { course_more_info: "Please input more info about the course!"}}, status: :unprocessable_entity
        return
      end
      course_more_info_param = course_more_info_param

      # create course
      created_course = Course.create(
        course_name: course_name_param,
        course_duration: course_duration_param,
        course_fee: course_fee_param,
        course_desc: course_desc_param,
        course_more_info: course_more_info_param,
      )

      if course_params[:course_image].present?
        created_course.course_image.attach(course_params[:course_image])
      end

      if created_course
        render json: { message: "Course '#{course_name_param}' created successfully!"}, status: :created
      else
        render json: { error: "Error creating course!", info: created_course.errors.full_messages }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # view single_course
  def single_course
    begin
      identifier = params[:identifier]

      # Try to find course by slug or ID
      info = Course.find_by(slug: identifier) || Course.find_by(id: identifier)

      if info.nil?
        render json: { errors: { course: "Course not found!" } }, status: :not_found
        return
      end

      # Attach image URL if available
      image_url = info.course_image.attached? ? url_for(info.course_image) : nil

      render json: info.as_json(
        except: [:created_at, :updated_at]
      ).merge({ image_url: image_url }), status: :ok

    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
  end

  # view all_courses
  def all_courses
    begin
      courses = Course.all.order(:id).to_a
      if courses.empty?
        render json: { error: "Empty List!"}, status: :not_found
        return
      end

      course_list = course_name_sort(courses)

      info = course_list.map do |course|
        image_url = nil
        if course.course_image.attached?
          image_url = url_for(course.course_image)
        else
          nil
        end
        course.as_json(except: [:created_at, :updated_at]).merge({ image_url: image_url})        
      end
      
      render json: info, status: :ok
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # update_course
  def update_course
    begin
      courses = Course.all.order(:id).to_a
      target_id = params[:id].to_i

      info = course_id_search(courses, target_id)
      if info.is_a?(Hash)
        render json: info, status: :unprocessable_entity
        return
      end

      updated_course_info = {}

      # course_name_param
      course_name_param = course_params[:course_name].to_s.downcase
      if course_name_param.present?
        # course_name should not exist
        existing_course_name = course_name_search(courses, course_name_param, target_id)
        if existing_course_name.is_a?(Hash)
          render json: existing_course_name, status: :unprocessable_entity
          return
        end
        course_name_param = existing_course_name.titleize
        updated_course_info[:course_name] = course_name_param

      end

      # course_duration_param
      course_duration_param = course_params[:course_duration]
      if course_duration_param.present?
        course_duration_param = course_duration_param.titleize
        updated_course_info[:course_duration] = course_duration_param
      end

      # course_fee_param
      course_fee_param = course_params[:course_fee]
      if course_fee_param.present?
        # course_fee should not be below 0
        if course_fee_param.length <= 0
          render json: { errors: { course_fee: "Course fee cannot be below 0"}}, status: :unprocessable_entity
          return
        end
        course_fee_param = course_fee_param
        updated_course_info[:course_fee] = course_fee_param
      end

      # course_desc_param
      course_desc_param = course_params[:course_desc].to_s
      if course_desc_param.present?
        course_desc_param = course_desc_param
        updated_course_info[:course_desc] = course_desc_param
      end

      # course_more_info_param
      course_more_info_param = course_params[:course_more_info].to_s
      if course_more_info_param.present?
        course_more_info_param = course_more_info_param
        updated_course_info[:course_more_info] = course_more_info_param
      end

      # course_image_param
      course_image_param = course_params[:course_image]
      if course_image_param.present?
        course_image_param = course_image_param
        updated_course_info[:course_image] = course_image_param
      end

      # update_course
      updated_course = Course.update(updated_course_info)
      if updated_course
        render json: { message: "Course updated successfully!"}, status: :ok
      else
        render json: { error: "Error updating course!", info: updated_course.errors.full_messages }, status: :unprocessable_entity
        return
      end

    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # delete_course
  def delete_course
    begin
      courses = Course.all.order(:id).to_a
      target_id = params[:id].to_i
      
      info = course_id_search(courses, target_id)
      if info.is_a?(Hash)
        render json: info, status: :unprocessable_entity
        return
      end
      info.destroy
      render json: { message: "Course '#{info.course_name}' deleted successfully?"}, status: :ok
    rescue => e
      render json: { error: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold course_params
  private
  def course_params
    params.require(:course).permit(:course_name, :course_duration, :course_fee, :course_desc, :course_more_info, :course_image)
  end
end
