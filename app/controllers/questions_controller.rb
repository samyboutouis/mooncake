class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text)
    end

    
    def create_form
        $course = Course.find(params[:course])
        @question = Question.all
    end

    def create
        @question = Question.new(question_params)
        if @question.save
            redirect_to question_path
        else
            redirect_to new_question_path
        end
    end

    def new
        puts "**********"
        @question = Question.new
    end

    def delete
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to @question
    end
end