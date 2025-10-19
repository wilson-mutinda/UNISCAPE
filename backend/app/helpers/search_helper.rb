module SearchHelper
  # course_name uniqueness
  def unique_course_name(courses, course_name)

    original_name = course_name
    course_name = course_name.to_s.downcase

    first_index = 0;
    last_index = courses.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_course = courses[mid_index]
      mid_course_name = mid_course.course_name.to_s.downcase

      if mid_course_name == course_name
        return { errors: { course_name: "Course name already exists!"}}
      elsif mid_course_name < course_name
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
    original_name
  end

  # search course by id
  def course_id_search(courses, target_id)
    first_index = 0;
    last_index = courses.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_course = courses[mid_index]
      mid_course_id = mid_course.id

      if mid_course_id == target_id
        return mid_course
      elsif mid_course_id < target_id
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
    { errors: { course_id: "Course not found!"}}
  end

  # search course by name
  def course_name_search(courses, target_name, course_name_id)
    target_name = target_name.to_s.downcase

    first_index = 0;
    last_index = courses.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_course = courses[mid_index]
      mid_course_name = mid_course.course_name.to_s.downcase

      if mid_course_name == target_name
        if mid_course.id != course_name_id
          return { errors: { course_name: "Course already exists!"}}
        end
        return mid_course
      elsif mid_course_name < target_name
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
  end

  def user_email_search(users, target_email)
    target_email = target_email.to_s.gsub(/\s+/, '').downcase

    first_index = 0;
    last_index = users.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_index_user = users[mid_index]
      mid_index_email = mid_index_user.email

      if mid_index_email == target_email
        return { errors: { email: "Email has been taken!"}}
      elsif mid_index_email < target_email
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end

    target_email
  end

  def user_phone_search(users, target_phone)
    target_phone = target_phone.to_s.gsub(/\s+/, '')

    first_index = 0;
    last_index = users.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_index_user = users[mid_index]
      mid_index_phone = mid_index_user.phone

      if mid_index_phone == target_phone
        return { errors: { phone: 'Phone has been taken!'}}
      elsif mid_index_phone < target_phone
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end

    target_phone
  end

  def user_slug_search(users, target)
    target = target.to_s.strip.downcase

    # Try seach by ID
    if target.match?(/^\d+$/)
      user = users.find { |u| u.id == target.to_i }
      if user
        return user
      else
        return { errors: { user: "User with ID #{target} not found!"}}
      end
    end

    # Try search by email
    user = users.find { |u| u.email.to_s.downcase == target }
    if user.present?
      return user
    end

    # Try search by slug
    user = users.find { |u| u.slug.to_s.downcase == target }
    if user.present?
      return user
    end

    # Fallback if nothing hapens
    { errors: { user: "User not found for '#{target}'"}}
  end

  def unique_email_search(users, target_email, user_id)
    target_email = target_email.to_s.strip.downcase

    first_index = 0;
    last_index = users.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2
      mid_index_user = users[mid_index]
      mid_user_email = mid_index_user.email.to_s.strip.downcase

      if mid_user_email == target_email
        if mid_index_user.id != user_id
          return { errors: { email: "Email has been taken!"}}
        end
        return mid_index_user
      elsif mid_user_email < target_email
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
  end

  def unique_phone_search(users, target_phone, user_id)
    target_phone = target_phone.to_s.strip

    first_index = 0;
    last_index = users.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_index_user = users[mid_index]
      mid_index_phone = mid_index_user.phone

      if mid_index_phone == target_phone
        if mid_index_user.id != user_id
          return { errors: { phone: "Phone has been taken!"}}
        end
        return mid_index_user
      elsif mid_index_phone < target_phone
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
  end

end