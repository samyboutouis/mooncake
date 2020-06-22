require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "creating question" do
    assert question = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    assert question.question_text == "why are you a good boi"
    assert question.question_type == "short answer"
  end

  test "question has many course requests" do
    question1 = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    question2 = Question.create(question_text: "do you like mooncakes", question_type: "multiple choice")
    course = Course.create(course_number: "201", capacity: 100)
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    req1 = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user, course: course)
    req1.questions << [question1, question2]
    question1.course_requests << req2

    assert question1.course_requests == [req1, req2]
    assert req1.questions == [question1, question2]
  end  
  
  test "question has many courses" do
    question1 = Question.create(question_text: "why are you a good boi", question_type: "short answer")
    question2 = Question.create(question_text: "do you like mooncakes", question_type: "multiple choice")
    course1 = Course.create(course_number: "201", capacity: 100)
    course2 = Course.create(course_number: "101", capacity: 100)
    course1.questions << [question1, question2]
    question1.courses << course2

    assert question1.courses == [course1, course2]
    assert course1.questions == [question1, question2]
  end 
  

end
