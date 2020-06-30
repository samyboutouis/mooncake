require "csv"

class CoursesController < ApplicationController
  def course_params
    params.require(:course).permit(:department, :course_number, :section_number, :capacity, prereqs_attributes: [:name])
  end

  def new
    @course = Course.new
    @prereqs = @course.prereqs.build
  end

  def create
    if course = Course.create(course_params)
      course.seats_taken = 0
      $current_user.courses << course
      file = params[:course][:file]
      CSV.foreach(file, :headers => true) do |row|
        course.permission_numbers.create(number: row[0], expire_date: row[7], used: false)
      end      
      prereqs_attributes = params["prereq_attributes"]
      prereqs_attributes.each do |name|
        prereqs = course.prereqs.create(name: name[1]["name"])
      end
      redirect_to questioncourse_path(course), alert: "Course created successfully."
    else
      redirect_to faculty_url, alert: "Error creating course."
    end
  end

  def delete
    id = params[:id]
    course = Course.find(id)
    course.destroy
    redirect_to faculty_url
  end

end

