class CoursesController < ApplicationController
  def course_params
    params.require(:course).permit(:department, :course_number, :section_number, :capacity, prereqs_attributes: [:name])
  end
  
  def index
    @course = Course.all
    #byebug
  end

  def new
    @course = Course.new
    @prereqs = @course.prereqs.build
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, alert: "Course created successfully."
    else
      redirect_to new_course_path, alert: "Error creating course."
    end
  end

  # def show
  #   @course = Course.find(params[:id])
  # end
end
