require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "creating course" do
    assert course = Course.create(capacity: 100, name: "cs 101")
    assert course.name == "cs 101"
  end

  test "course has many course_requests" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    user2 = User.create(first_name: "Mapple", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(name: "cs 101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user2, course: course)

    assert course.course_requests == [req, req2]
  end
end
