class QuestionsController < ApplicationController
    def question_params
        params.require(:question).permit(:question_type, :question_text, :option => [])
    end

    # initializing the course
    def course
        $course = nil
        $course = Course.find(params[:course])
        redirect_to question_path
    end

    # main page for creating form with default questions
    def create_form
        $course.questions = Course.find($course.id).questions
        # if $course.questions.count == 0
        #     $course.questions << Question.find(1,2,3,4,5,6,7)
        # end
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
        id = params[:id]
        $course.questions.destroy(Question.find(id))
        # if id.to_i > 7
        #     Question.destroy(id)
        # end
        Question.destroy(id)
        redirect_to question_path
    end

end

