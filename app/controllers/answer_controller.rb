class AnswerController < ApplicationController
    # skip_before_action :faculty_check
    def form 
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        @course = Course.find(params[:course_request])
    end

    def data
        # retrieve data using param
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        @course = Course.find_by(department: params[:department], course_number: params[:course_number], section_number: params[:section_number])
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
        # UserMailer.with(user: session[:current_user], request: @course_request).request_submitted.deliver_now
        redirect_to root_url
    end

end


