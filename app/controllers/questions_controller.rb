class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text)
    end

    # initializing the course
    def course
        $course = nil
        $course = Course.find(params[:course])
        redirect_to question_path
    end

    # main page for creating form
    def create_form
        $course.questions = Course.find($course.id).questions
        if $course.questions.count == 0
            $course.questions << Question.find(42,43,44)
        end
        @question = $course.questions
    end

    def create
        $course.questions.create(question_params)
        redirect_to question_path
    end

    # add new question
    def new
        @question = Question.new
    end

    # delete question
    def delete
        $course.questions.destroy(Question.find(params[:id]))
        Question.destroy(Question.find(params[:id]))
        redirect_to question_path
    end
end