class CoursesController < ApplicationController
  def course_params
    params.require(:course).permit(:department, :course_number, :section_number, :capacity)
  end
  
  def index
    @course = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to question_path(@course), alert: "Course created successfully."
    else
      redirect_to new_course_path, alert: "Error creating course."
    end
  end

  # def show
  #   @course = Course.find(params[:id])
  # end
end
