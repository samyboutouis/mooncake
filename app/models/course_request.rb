class CourseRequest < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :answers
  has_many :questions, through: :answers
  has_one :permission_number
end
