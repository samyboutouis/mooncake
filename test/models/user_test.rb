require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "creating user" do
    assert user = User.create(first_name: "Mapple", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    assert user.first_name == "Mapple"
    assert user.last_name == "Adkisson"
    assert user.grad_year == 2020
    assert user.major == "Computer Science"
    assert user.user_type == "doggo"
  end
end
