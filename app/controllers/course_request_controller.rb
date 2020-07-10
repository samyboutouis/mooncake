class CourseRequestController < ApplicationController
    # skip_before_action :faculty_check
    # def expand
    #     term = params[:term]
    #     department = params[:department]
    #     number = params[:number]
    #     @course = Course.where(term:term, department: department, course_number: number)
    #     @course_request = CourseRequest.where(user: session[:current_user], course: @course)
    #     respond_to do |format|
    #         format.json {render json: @course_request}
    #     end
    # end

    def index
        @course = Course.where(published: true)
    end

    def term
        term = params[:term]
        @course = Course.where(term: term, published: true)
        respond_to do |format|
            format.json {render json: @course}
        end
    end

    def department
        term = params[:term]
        department = params[:department]
        @course = Course.where(term: term, department: department, published: true)
        respond_to do |format|
            format.json {render json: @course}
        end
    end

    def section
        term = params[:term]
        department = params[:department]
        course_number = params[:course_number]
        @course = Course.where(term: term, department: department, course_number: course_number, published: true)
        respond_to do |format|
            format.json {render json: @course}
        end
    end

    def new
        @course_request = CourseRequest.new
    end

    def submit
        @course = Course.find_by(term: params[:term], department: params[:department], course_number: params[:course_number], section_number: params[:section_number], published: true)
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        redirect_to answer_path(@course)
    end
end
