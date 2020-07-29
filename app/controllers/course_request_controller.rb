class CourseRequestController < ApplicationController
    skip_before_action :faculty_check

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
        if @user.course_requests.pluck(:course_id).include? @course.id
            flash[:alert1] = "You have already requested a permission number for this course. Try again"
            redirect_to search_path
        else
            redirect_to answer_path(@course)
        end


    end
end
