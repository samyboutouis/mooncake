class Question < ApplicationRecord
    has_and_belongs_to_many :course_requests
    has_and_belongs_to_many :courses
end
