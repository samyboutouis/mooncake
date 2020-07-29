class QuestionsController < ApplicationController
    skip_before_action :student_check
    def question_params
        defaults = {option: []}
        params.require(:question).permit(:question_type, :question_text, :option => []).reverse_merge(defaults)
    end

    # initializing the course
    def create_form
        @course = Course.find(params[:course])
        if @course.published == true
            redirect_to faculty_page_path
        end
        if @course.questions.count == 0
            @course.questions << Question.find(1,2,3,4,5)
            if @course.prereqs.first != nil
                @course.questions.create(question_type:  "Checkbox", question_text: "Which prerequisite(s) have you satisfied:", option: @course.prereqs.pluck(:name))
            end
        end
        for crse in Course.where(term: @course.term, department: @course.department, course_number: @course.course_number) do
            if crse.id != @course.id
                if crse.questions.count == 0
                    crse.questions << Question.find(1,2,3,4,5)
                    if crse.prereqs.first != nil
                        crse.questions.create(question_type:  "Checkbox", question_text: "Which prerequisite(s) have you satisfied:", option: crse.prereqs.pluck(:name))
                    end
                end
            end
        end
        @question = @course.questions
    end

    def create
        @course = Course.find(params[:course])
        if @course.published == true
            redirect_to faculty_page_path
        end
        @course.questions.create(question_params)
        for crse in Course.where(term: @course.term, department: @course.department, course_number: @course.course_number) do
            if crse.id != @course.id
                crse.questions << @course.questions.last
            end
        end

        redirect_to question_path(@course)
    end

    # add new question
    def new
        @course = Course.find(params[:course])
        if @course.published == true
            redirect_to faculty_page_path
        end
        @question = Question.new
    end

    # delete question
    def delete
        @question = Question.find(params[:id])
        @course = Course.find(params[:course])
        @course.questions.delete(params[:id])
        for crse in Course.where(term: @course.term, department: @course.department, course_number: @course.course_number) do
            if crse.id != @course.id
                crse.questions.delete(params[:id])
            end
        end
        redirect_to question_path(@course)
    end

    def save_template
        @course = Course.find(params[:course])
        if @course.prereqs.first != nil
           n = 6
        else
            n = 5
        end
        questionids = @course.questions.pluck(:question_id).slice(n, @course.questions.count+1)
        questionids = questionids.join("~")
        if params[:template_name] == nil
            name = @course.department.split("-").first + " "+ @course.course_number + " - " + @course.section_number + "template"
        else
            name = params[:template_name]
        end
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        @user.form_templates.create(name: name, questionids: questionids)
        redirect_to question_path(@course)
    end

    def load_template
        @course = Course.find(params[:course])
        @template = FormTemplate.find(params[:template])
        for question in @course.questions
            if question.id  < 6 || question.question_text == "Which prerequisite(s) have you satisfied:"
                next
            else
                @course.questions.delete(question.id)
            end
        end

        for id in @template.questionids.split("~")
            if @course.questions.pluck(:question_id).include? id.to_i
                next
            else
                @course.questions << Question.find(id)
                for crse in Course.where(term: @course.term, department: @course.department, course_number: @course.course_number) do
                    if crse.id != @course.id
                        crse.questions << Question.find(id)
                    end
                end
            end
        end
        redirect_to question_path(@course)
    end

end
