class Course < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :prereqs, inverse_of: :course
    has_and_belongs_to_many :questions
    has_many :course_requests
    has_many :permission_numbers
    accepts_nested_attributes_for :prereqs, allow_destroy: true
end
