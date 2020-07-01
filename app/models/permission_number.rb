class PermissionNumber < ApplicationRecord
  belongs_to :course
  belongs_to :course_request, optional: true
end
