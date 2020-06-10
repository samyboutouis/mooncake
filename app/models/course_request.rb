class CourseRequest < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_and_belongs_to_many :questions
end
