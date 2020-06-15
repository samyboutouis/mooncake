class CourseRequest < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_one :permission_number
  has_and_belongs_to_many :questions
end
