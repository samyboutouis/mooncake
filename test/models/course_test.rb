require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  
  test "creating course" do
    assert course = Course.create(capacity: 100, course_number: "101")
    assert course.course_number == "101"
  end

  test "course has many course_requests" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    user2 = User.create(first_name: "Mapple", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(course_number: "101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user2, course: course)
    assert course.course_requests == [req, req2]
  end

  test "course has many permission numbers" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(course_number: "101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    pn1 = PermissionNumber.create(number: "010115", expire_date: "09/30/2020", course: course, course_request: req)
    pn2 = PermissionNumber.create(number: "999999", expire_date: "09/30/2020", course: course, course_request: req)
    
    assert course.permission_numbers == [pn1, pn2]
  end  

  test "course has and belongs many users" do
    user1 = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    user2 = User.create(first_name: "Danai", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course1 = Course.create(course_number: "101")
    course2 = Course.create(course_number: "201")
    user1.courses << [course1, course2]
    course1.users << user2
    assert course1.users == [user1, user2]
    assert user1.courses == [course1, course2]
  end  

end
