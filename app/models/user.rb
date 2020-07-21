class User < ApplicationRecord
    has_and_belongs_to_many :courses
    has_many :course_requests
    has_many :form_templates
end
