require 'test_helper'

class PrereqTest < ActiveSupport::TestCase
  test "creating prereq" do
    assert prereq = Prereq.create(name: "math 101")
    assert prereq.name == "math 101"
  end
end
