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
        $course.questions = Course.find($course.id).questions
        @question = $course.questions
    end

    def create
        $course.questions.create(question_params)
        redirect_to question_path
    end

    def new
        @question = Question.new
    end

    def delete
        $course.questions.destroy(Question.find(params[:id]))
        Question.destroy(Question.find(params[:id]))
        redirect_to question_path
    end
end