module CoursesHelper
  def my_courses(course)
    return nil
  end

  def no_course(user)
      if user.courses.length() == 0
          return '<p>You have created no courses for this term</p>'.html_safe
      else
          return nil
      end
  end
end
