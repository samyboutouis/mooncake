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
      file = params[:course][:file]
      CSV.foreach(file, :headers => true) do |row|
        puts row[0]
        puts row[7]
        course.permission_numbers.create(number: row[0], expire_date: row[7], used: false)
      end      
      course.seats_taken = 0
      prereqs_attributes = params["prereq_attributes"]
      prereqs_attributes.each do |name|
        prereqs = course.prereqs.create(name: name[1]["name"])
      end
      $current_user.courses << course
      redirect_to questioncourse_path(course), alert: "Course created successfully."
    else
      redirect_to faculty_url, alert: "Error creating course."
    end
  end

  def delete
    id = params[:id]
    course = Course.find(id)
    course.prereqs.each do |prereq|
      prereq.destroy
    end
    course.course_requests.each do |request|
      request.answers.each do |answer|
        answer.destroy 
      end
      request.destroy
    end
    course.questions.each do |question|
      question.destroy
    end
    course.permission_numbers.each do |number|
      number.destroy
    end
    $current_user.courses.destroy(course)
    Course.destroy(id)
    redirect_to faculty_url
  end

end

