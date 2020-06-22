class CourseRequestController < ApplicationController
    def display
        department = params[:department]
        number = params[:number]
        @course_request = Course
    end
  end