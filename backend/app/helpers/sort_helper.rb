module SortHelper
  def course_name_sort(courses)
    if courses.length <= 1
      return courses
    end

    pivot = courses.delete_at(rand(courses.length))

    left, right = courses.partition do |course|
      course.course_name < pivot.course_name
    end

    course_name_sort(left) + [pivot] + course_name_sort(right)
  end

  def user_email_sort(users)
    if users.length <= 1
      return users
    end

    pivot = users.delete_at(rand(users.length))

    left, right = users.partition do |user|
      user.email < pivot.email
    end

    user_email_sort(left) + [pivot] + user_email_sort(right)
  end
end