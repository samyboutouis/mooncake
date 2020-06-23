class CourseRequestController < ApplicationController
    def show
        department = params[:department]
        number = params[:number]
        @course = Course.where(department: department, course_number: number)
        @course_request = CourseRequest.where(user: $current_user, course: @course)
        respond_to do |format|
            format.json {render json: @course_request}
        end
    end

    def search
        @courses = Course.all
    end

    def department
        department = params[:department]
        @courses = Course.where(department: department)
        respond_to do |format|
            format.json {render json: @courses}
        end
    end

    def section
        department = params[:department]
        course_number = params[:course_number]
        @courses = Course.where(course_number: course_number, department: department)
        respond_to do |format|
            format.json {render json: @courses}
        end
    end

    def data_request
        # user = $current_user
        # department = params["department"]
        # course_number = params["course_number"]
        # section_number = params["section_number"]
        # course = Course.where(department: department, course_number: course_number, section_number: section_number)
        # request = CourseRequest.create(course: course, user: user, status: "under review")
        # puts request
    end
end