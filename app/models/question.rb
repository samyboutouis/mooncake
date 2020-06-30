class Question < ApplicationRecord
    serialize :option, Array
    has_many :answers, :dependent => :delete_all
    has_many :course_requests, through: :answers, :dependent => :delete_all
    has_and_belongs_to_many :courses
  end
