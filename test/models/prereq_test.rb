require 'test_helper'

class PrereqTest < ActiveSupport::TestCase
  
  test "creating prereq" do
    assert prereq = Prereq.create(name: "math 101")
    assert prereq.name == "math 101"
  end

  test "prereq has and belongs to many courses" do
    course1 = Course.create(course_number: "250", capacity: 100)
    course2 = Course.create(course_number: "201", capacity: 100)
    prereq1 = Prereq.create(name: "cs 101")
    prereq2 = Prereq.create(name: "cs 216")
    course1.prereqs << prereq1
    course2.prereqs << prereq1
    prereq2.courses << course1
    prereq2.courses << course2
    assert course1.prereqs.first == prereq1
    assert course2.prereqs.first == prereq1
    assert prereq2.courses == [course1, course2]
  end

end
