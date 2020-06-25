class FormController < ApplicationController
    def form 
        @user = $current_user
    end

    def data
        # retrieve data using param
        @user = $current_user
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