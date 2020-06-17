require 'test_helper'

class PermissionNumberTest < ActiveSupport::TestCase

  test "creating permission_number" do
    date = DateTime.now + 56.days
    assert permission = PermissionNumber.create(expire_date: date, number: 123456)
    assert permission.expire_date == date
    assert permission.number == 123456
  end

  test "permission number belongs to course_request" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(course_number: "101", capacity: 100)
    req = CourseRequest.create(status: "under review", user: user, course: course)
    pn = PermissionNumber.create(number: 010115, expire_date: DateTime.parse("2021-1-1"), course: course, course_request: req)

    assert req.permission_number == pn
  end


end
