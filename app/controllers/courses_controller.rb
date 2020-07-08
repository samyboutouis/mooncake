require "csv"

class CoursesController < ApplicationController
  # skip_before_action :student_check
  def course_params
    params.require(:course).permit(:department, :course_number, :section_number, :capacity, prereqs_attributes: [:name])
  end

  def new
    @course = Course.new
    @prereqs = @course.prereqs.build
  end

  def create
    if course = Course.create(course_params)
      course.published = false
      course.primary = true
      course.seats_taken = 0
      User.find_by(net_id: session[:current_user]["net_id"]).courses << course  
      file = params[:course][:file]
      CSV.foreach(file, :headers => true) do |row|
        unless row[0] == nil
          course.permission_numbers.create(number: row[0], expire_date: row[7], used: false)
        end
      end      
      prereqs_attributes = params["prereq_attributes"]
      prereqs_attributes.each do |name|
        prereqs = course.prereqs.create(name: name[1]["name"])
      end
      # UserMailer.with(user: session[:current_user], course: course).course_created.deliver_now
      i = 1
      cl = Array.new
      while (i < (params["number-choice"].to_i) +1)
        dep = "department" + i.to_s
        num = "course_number" + i.to_s
        sec = "section_number" + i.to_s
        file = "file" + i.to_s
        Course.create(department: params[dep], course_number: params[num],
        section_number: params[sec], primary: false, seats_taken: 0, capacity: course.capacity)
        cl.append(Course.last.id)
        Course.last.prereqs << course.prereqs
        file = params[file]
        CSV.foreach(file, :headers => true) do |row|
          unless row[0] == nil
            Course.last.permission_numbers.create(number: row[0], expire_date: row[7], used: false)
          end
        end 
        i += 1
      end
      course.update(cross_listing: cl)
      redirect_to question_path(course), alert: "Course created successfully."
    else
      redirect_to faculty_page_url, alert: "Error creating course."
    end
  end

  def delete
    id = params[:id]
    course = Course.find(id)
    course.cross_listing.each do |id|
      Course.destroy(id)
    end
    course.destroy
    redirect_to faculty_page_url
  end

end

