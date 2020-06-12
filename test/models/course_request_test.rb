require 'test_helper'

class CourseRequestTest < ActiveSupport::TestCase
  test "creating course_request" do
    assert request = CourseRequest.create(status: "under review")
    assert request.status == "under review"
  end

  test "course_request belongs to course and user" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(name: "cs 101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    
    assert req.course == course
    assert req.user == user
  end

  
end
