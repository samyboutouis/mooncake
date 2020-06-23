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
end