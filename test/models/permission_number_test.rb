require 'test_helper'

class PermissionNumberTest < ActiveSupport::TestCase
  test "creating permission_number" do
    assert permission = PermissionNumber.create(expire_date: "08/30/2020", number: "123456")
    assert permission.expire_date == "08/30/2020"
    assert permission.number == "123456"
  end
end
