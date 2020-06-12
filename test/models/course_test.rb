require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "creating course" do
    assert course = Course.create(capacity: 100, name: "cs 101")
    assert course.name == "cs 101"
  end
end
