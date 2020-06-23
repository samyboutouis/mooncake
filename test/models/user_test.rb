require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "creating user" do
    assert user = User.create(first_name: "Mapple", last_name: "Adkisson", grad_year: "2020 sprng", major: "Computer Science", user_type: "doggo")
    assert user.first_name == "Mapple"
    assert user.last_name == "Adkisson"
    assert user.grad_year == "2020 sprng"
    assert user.major == "Computer Science"
    assert user.user_type == "doggo"
  end

  test "user has many course_requests" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: "2020 sprng", major: "Computer Science", user_type: "doggo")
    course = Course.create(course_name: "COMPSCI101")
    course2 = Course.create(course_name: "COMPSCI201")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user)

    assert user.course_requests.first == req
    assert course2.course_requests << req2
    assert user.course_requests == [req, req2]
  end

end
