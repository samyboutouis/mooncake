class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :course_request
end
