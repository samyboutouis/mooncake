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
                answer = params[question.question_text].join("~")
            else
                answer = params[question.question_text]
            end
            $course_request.answers.create(answer_text: answer, question: question)
            # Answer.last << Question.find_by(question_text: question.question_text)
        end
        puts params["major"]
        redirect_to root_url
    end

    # def question_params
    #     params.require(:question).permit(:question_type, question_text)
    #   end
    

    # def create_form
    #     @question = Question.all
    #     puts @question.all
    # end

    # def create_question
    #     @question = Question.new(question_params)
    #     if @question.save
    #         redirect_to @form
    #     else
    #         redirect_to new_question_path
    #     end
    # end

    # def new
    #     @question = Question.new
    # end
end


