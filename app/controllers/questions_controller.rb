class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text)
    end

    def course
        $course = nil
        $course = Course.find(params[:course])
        redirect_to question_path
    end

    def create_form
        @question = Question.all
        $course.questions << @question
    end

    def create
        @question = Question.new(question_params)
        if @question.save
            redirect_to @question
        else
            redirect_to new_question_path
        end
    end

    def new
        @question = Question.new
    end

    def delete
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to @question
    end
end