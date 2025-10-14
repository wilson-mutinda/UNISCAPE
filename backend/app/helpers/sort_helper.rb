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
end