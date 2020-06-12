require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "creating question" do
    assert question = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    assert question.question_text == "why are you a good boi"
    assert question.question_type == "short answer"
  end
end
