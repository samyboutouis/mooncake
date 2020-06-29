module CoursesHelper
  def my_courses(course)
    return nil
  end

  def course_status(course)
    if course.seats_taken < course.capacity
        return '<div id="circle" class="circle green"></div>'.html_safe
    else
        return '<div class="circle red"></div>'.html_safe
    end
  end

  def no_course(user)
      if user.courses.length() == 0
          return '<p>You have created no courses for this term</p>'.html_safe
      else
          return nil
      end
  end
end
