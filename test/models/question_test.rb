require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  
  test "creating question" do
    assert question = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    assert question.question_text == "why are you a good boi"
    assert question.question_type == "short answer"
  end

  test "question has many course requests" do
    question = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    course = Course.create(name: "cs 201", capacity: 100)
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    req1 = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user, course: course)

    assert question.requests == [req1, req2]
  end  

  test "question belongs to many course requests" do
    question = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    course = Course.create(name: "cs 201", capacity: 100)
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    req1 = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user, course: course)

    assert req1.question == question 
    assert req2.question == question;
  end  

end
