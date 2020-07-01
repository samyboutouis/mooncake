class AnswerController < ApplicationController

    def form 
        @user = $current_user
        @course = Course.find(params[:course_request])
        @@course_submit = @course
    end

    def data
        # retrieve data using param
        @user = User.find_by(net_id: $current_user.net_id)
        @course = Course.find(@@course_submit.id)
        @course_request = CourseRequest.create(status: "Under Review", course: @course, user: @user)
        for question in @course_request.course.questions
            if question.question_type == "Checkbox"
                if params[question.question_text] == nil
                    answer = ""
                else
                    answer = params[question.question_text].join("~")
                end
            else
                answer = params[question.question_text]
            end
            @course_request.answers.create(answer_text: answer, question: question)
            # Answer.last << Question.find_by(question_text: question.question_text)
        end
        redirect_to root_url
    end

end


