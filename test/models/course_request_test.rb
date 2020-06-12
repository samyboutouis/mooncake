require 'test_helper'

class CourseRequestTest < ActiveSupport::TestCase
  test "creating course_request" do
    assert request = CourseRequest.create(status: "under review")
    assert request.status == "under review"
  end
end
