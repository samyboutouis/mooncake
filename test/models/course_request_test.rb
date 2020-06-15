require 'test_helper'

class CourseRequestTest < ActiveSupport::TestCase
  
  test "creating course_request" do
    assert request = CourseRequest.create(status: "under review")
    assert request.status == "under review"
  end

  test "course_request belongs to course and user" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(name: "cs 101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    
    assert req.course == course
    assert req.user == user
  end

  test "course request has and belongs to many questions" do
    user = User.create(first_name: "Corgi", last_name: "Adkisson", grad_year: 2020, major: "Computer Science", user_type: "doggo")
    course = Course.create(name: "cs 101")
    req = CourseRequest.create(status: "under review", user: user, course: course)
    req2 = CourseRequest.create(status: "rejected", user: user, course: course)
    question1 = Question.create(question_type: "multiple choice", question_text: "do you like mooncake?")
    question2 = Question.create(question_type: "multiple choice", question_text: "do you like Danai?")
    req.questions << [question1, question2]
    question1.course_requests << req2
    assert req.questions == [question1, question2]
    assert question1.course_requests == [req, req2]
  end

  
end
