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
        if @course.primary == false
            course1 = @course.cross_listing[0]
            total = course1.course_requests.count
            name = course1.department.split("-").first + " "+ course1.course_number + " - " + course1.section_number
            for id in course1.cross_listing 
                c = Course.find(id)
                total += c.course_requests.count
                name += " / " + c.department.split("-").first + " "+ c.course_number + " - " + c.section_number
            end
        else
            course1 = @course
            total = course1.course_requests.count
            name = course1.department.split("-").first + " "+ course1.course_number + " - " + course1.section_number
            for id in course1.cross_listing 
                c = Course.find(id)
                total += c.course_requests.count
                name += " / " + c.department.split("-").first + " "+ c.course_number + " - " + c.section_number
            end
        end
        if total%10 == 0
            email = course1.user.email
            UserMailer.with(email: email, coursename: name, total: total, course: course1.id).many_requests.deliver_now
        end
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
        UserMailer.with(user: @user, request: @course_request).request_submitted.deliver_now
        redirect_to root_url
    end

end


