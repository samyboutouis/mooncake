require 'test_helper'

class PrereqTest < ActiveSupport::TestCase
  
  test "creating prereq" do
    assert prereq = Prereq.create(name: "math 101")
    assert prereq.name == "math 101"
  end

  test "prereq has many courses" do
    course1 = Course.create(name: "cs 101", capacity: 100)
    course2 = Course.create(name: "cs 201", capacity: 100)
    prereq = Prereq.create(name: "cs 250")
    assert prereq.courses == [course1, course2]
  end

  test "prereq belongs to many courses" do
    course1 = Course.create(name: "cs 250", capacity: 100)
    course2 = Course.create(name: "cs 201", capacity: 100)
    prereq = Prereq.create(name: "cs 101")
    assert course1.prereq == prereq 
    assert course2.prereq == prereq
  end

end
