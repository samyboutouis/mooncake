class CoursesController < ApplicationController
  def course_params
    params.require(:course).permit(:department, :course_number, :section_number, :capacity, prereqs_attributes: [:name])
  end
  
  def index
    @user = $current_user
    @course = @user.courses
    #byebug
  end

  def new
    @course = Course.new
    @prereqs = @course.prereqs.build
  end

  def create

    if course = Course.create(course_params)
      prereqs_attributes = params["prereq_attributes"]
      prereqs_attributes.each do |name|
        prereqs = course.prereqs.create(name: name[1]["name"])
      end
      $current_user.courses << course
      redirect_to questioncourse_path(course), alert: "Course created successfully."
    else
      redirect_to new_course_path, alert: "Error creating course."
    end

  end

  def show
    @course = Course.find(params[:id])
  end

  def delete
    id = params[:id]
    $current_user.courses.destroy(Course.find(id))
    Course.destroy(id)

    redirect_to course_url
  end

end

