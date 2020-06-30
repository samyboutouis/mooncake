class AnswerController < ApplicationController

    def form 
        @user = $current_user
        @course_request = CourseRequest.find(params["course_request"])
        $course_request = @course_request
    end

    def data
        # retrieve data using param
        @user = $current_user
        for question in $course_request.course.questions
            if question.question_type == "Checkbox"
                if params[question.question_text] == nil
                    answer = ""
                else
                    answer = params[question.question_text].join("~")
                end
            else
                answer = params[question.question_text]
            end
            $course_request.answers.create(answer_text: answer, question: question)
            # Answer.last << Question.find_by(question_text: question.question_text)
        end
        redirect_to root_url
    end

end


