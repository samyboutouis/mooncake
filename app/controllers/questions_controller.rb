class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text, :option => [])
    end

    # initializing the course
    def create_form
        @course = Course.find(params[:course])
        if @course.questions.count == 0
            @course.questions << Question.find(1,2,3,4,5)
            if @course.prereqs.first != nil
                @course.questions.create(question_type:  "Checkbox", question_text: "Which course(s) have you taken:", option: @course.prereqs.pluck(:name))
            end
        end
        @question = @course.questions
    end

    def create
        @course = Course.find(params[:course])
        @course.questions.create(question_params)
        redirect_to question_path(@course)
    end

    # add new question
    def new
        @course = params[:course]
        @question = Question.new
    end

    # delete question
    def delete
        @question = Question.find(params[:id])
        @course = @question.courses.first
        @question.destroy
        redirect_to question_path(@course)
    end

end

