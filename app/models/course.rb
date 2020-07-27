class Course < ApplicationRecord
    serialize :cross_listing, Array
    has_and_belongs_to_many :users
    has_and_belongs_to_many :prereqs
    before_destroy do
        prereqs.each { |prereq| prereq.destroy }
    end
    has_and_belongs_to_many :questions

    has_many :course_requests
    before_destroy do
        course_requests.each do |course_request|
            course_request.answers.each do |answer|
                answer.destroy
            end
            if course_request.permission_number.nil?
            else
                course_request.permission_number.destroy
            end
            course_request.destroy
        end
    end
    has_many :permission_numbers, :dependent => :delete_all
    accepts_nested_attributes_for :prereqs, allow_destroy: true
end
