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

  # course_slug_search
  def course_slug_search(courses, target)
    target = target.to_s.gsub(/\s+/, '').downcase

    # check if target is ad ID
    if target.match?(/^\d+$/)
      course = courses.find { |c| c.id == target.to_i }
      if course
        return course
      else
        return { errors: { course: "Course with ID #{target} not found!"}}
      end
    end

    # Try search with course_name
    course = courses.find { |c| c.course_name.to_s.downcase == target }
    if course
      return course
    end

    # Try search with slug
    course = courses.find { |c| c.slug.to_s.downcase == target }
    if course
      return course
    end

    # Fallback if nothing happens
    { errors: { course: "Course not found for '#{target}'"}}
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

  def country_name_search(countrys, target_name)
    target_name = target_name.to_s.downcase
    first_index = 0;
    last_index = countrys.length - 1

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_country = countrys[mid_index]
      mid_country_name = mid_country.name.to_s.downcase

      if mid_country_name == target_name
        return { errors: { name: "Name already exists!"}}
      elsif mid_country_name < target_name
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end
    end
    target_name
  end

  def country_slug_search(countrys, target)
    target = target.to_s.gsub(/\s+/, '').downcase

    # check id target is an ID
    if target.match?(/^\d+$/)
      country = countrys.find { |c| c.id == target.to_i }
      if country
        return country
      else
        return { errors: { name: "Country with ID #{target} not found!"}}
      end
    end

    # find by name
    country = countrys.find { |c| c.name.to_s.downcase == target }
    if country
      return country
    end

    # find by slug
    country = countrys.find { |c| c.slug.to_s.downcase == target }
    if country
      return country
    end

    # Falback if nothing happens
    { errors: { name: "Country not found for '#{target}'"}}
  end

  def unique_country_name(countrys, target_name, country_id)
    target_name = target_name.to_s.downcase
    first_index = 0;
    last_index = countrys.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_index_country = countrys[mid_index]
      mid_index_name = mid_index_country.name.to_s.downcase
      
      if mid_index_name == target_name
        if mid_index_country.id != country_id
          return { errors: { name: "Name already exists!"}}
        end
        return mid_index_country
      elsif mid_index_name < target_name
        first_index = mid_index + 1;
      else
        last_index = mid_index - 1;
      end

    end
  end

  def student_slug_search(students, target)
    target = target.to_s.gsub(/\s+/, '').downcase

    # check if target is an ID
    if target.match?(/^\d+$/) && target.length < 7
      student = students.find { |s| s.id == target.to_i }
      if student
        return student
      else
        return { errors: { student: "Student with ID #{target} not found!"}}
      end
    end

    # find with slug
    student = students.find { |s| s.slug.to_s.gsub(/\s+/, '').downcase == target }
    if student
      return student
    end

    # find with first_name
    student = students.find { |s| s.first_name.to_s.strip.downcase == target }
    if student
      return student
    end

    # find with last_name
    student = students.find { |s| s.last_name.to_s.strip.downcase == target }
    if student
      return student
    end

    # find with user.slug (if user exists)
    student = students.find { |s| s.user && s.user.slug.to_s.strip.downcase == target }
    if student
      return student
    end

    # find with user.email (if user exists)
    student = students.find { |s| s.user && s.user.email.to_s.gsub(/\s+/, '').downcase == target }
    if student
      return student
    end

    # find with user.phone (if user exists) 
    student = students.find { |s| s.user && s.user.phone.to_s.gsub(/\s+/, '') == target }
    if student
      return student
    end

    # Fallback if nothing happens
    { errors: { student: "Student not found for '#{target}'"}}
  end

  def login_email_search(users, target_email)
    target_email = target_email.to_s.gsub(/\s+/, '').downcase
    first_index = 0;
    last_index = users.length - 1;

    while first_index <= last_index
      mid_index = (first_index + last_index) / 2;
      mid_user = users[mid_index]
      mid_user_email = mid_user.email

      if mid_user_email == target_email
        return mid_user_email
      elsif mid_user_email < target_email
        first_index = mid_index + 1        
      else
        last_index = mid_index - 1
      end
    end
    { errors: { email: "Email '#{target_email}' not found!"}}
  end

end