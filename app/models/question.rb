class Question < ApplicationRecord
    serialize :option, Array
    has_many :answers
    has_many :course_requests, through: :answers
    has_and_belongs_to_many :courses
  end
