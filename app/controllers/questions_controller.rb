class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text, :option => [])
    end

    # initializing the course
    def course
        @course3 = nil
        @course3 = Course.find(params[:course])
        redirect_to question_path
    end

    # main page for creating form with default questions
    def create_form
        puts @course3
        @course3.questions = Course.find(@course3.id).questions
        if @course3.questions.count == 0
            @course3.questions << Question.find(1,2,3,4,5)
            if @course3.prereqs.first.name != ""
                @course3.questions.create(question_type:  "Checkbox", question_text: "Which course(s) have you taken:", option: @course3.prereqs.pluck(:name))
            end
        end
        @question = @course3.questions
    end

    def create
        @course3.questions.create(question_params)
        redirect_to question_path
    end

    # add new question
    def new
        @question = Question.new
    end

    # delete question
    def delete
        id = params[:id]
        @course3.questions.destroy(Question.find(id))
        if id.to_i > 5
            Question.destroy(id)
        end
        redirect_to question_path
    end

end

