class Answer < ApplicationRecord
  belongs_to :course_request
  belongs_to :question
end
