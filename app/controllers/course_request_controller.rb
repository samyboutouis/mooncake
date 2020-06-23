class CourseRequestController < ApplicationController
    def show
        department = params[:department]
        name = params[:name]
        @course = Course.where(department: department, course_name: name)
        @course_request = CourseRequest.where(user: $current_user, course: @course)
        respond_to do |format|
            format.json {render json: @course_request}
        end
    end
end