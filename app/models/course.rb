class Course < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :prereqs, :dependent => :delete_all
    has_and_belongs_to_many :questions, :dependent => :delete_all
    has_many :course_requests, :dependent => :delete_all
    has_many :permission_numbers, :dependent => :delete_all
    accepts_nested_attributes_for :prereqs, allow_destroy: true
end
