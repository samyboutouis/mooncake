class CourseRequestController < ApplicationController
    def expand
        department = params[:department]
        number = params[:number]
        @course = Course.where(department: department, course_number: number)
        @course_request = CourseRequest.where(user: $current_user, course: @course)
        respond_to do |format|
            format.json {render json: @course_request}
        end
    end

    def index
        @course = Course.all
    end

    def department
        department = params[:department]
        @course = Course.where(department: department)
        respond_to do |format|
            format.json {render json: @course}
        end
    end

    def section
        department = params[:department]
        course_number = params[:course_number]
        @course = Course.where(course_number: course_number)
        respond_to do |format|
            format.json {render json: @course}
        end
    end

    def new
        @course_request = CourseRequest.new
    end

    def create
        @course = Course.find_by(department: params[:department], course_number: params[:course_number], section_number: params[:section_number])
        @user = User.find_by(net_id: $current_user.net_id)
        @course_request = CourseRequest.new(status: "Under Review", course: @course, user: @user)
        if @course_request.save
            redirect_to answer_path(@course_request), alert: "Course Request created successfully."
        else
            render :new
        end
    end
end
