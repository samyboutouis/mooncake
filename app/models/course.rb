class Course < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :prereqs
    before_destroy do
        prereqs.each { |prereq| prereq.destroy }
    end
    has_and_belongs_to_many :questions
    before_destroy do
        questions.each { |question| question.destroy if question.id>6 }
    end
    has_many :course_requests
    before_destroy do
        course_requests.each do |course_request|
            course_request.answers.each do |answer|
                answer.destroy
            end
        course_request.destroy
        end
    end
    has_many :permission_numbers, :dependent => :delete_all
    accepts_nested_attributes_for :prereqs, allow_destroy: true
end
