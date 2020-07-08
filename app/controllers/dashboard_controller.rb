class DashboardController < ApplicationController
  # skip_before_action :faculty_check, only: [:index, :withdraw, :view]
  # skip_before_action :student_check, only: [:faculty_index, :facreqview, :deny, :addpermnum, :accept, :add]
  def index
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    @course_request = @user.course_requests
  end

  def withdraw
    # Answer.destroy(Answer.where(course_request: params[:request]))
    CourseRequest.destroy(params[:request])
    redirect_to root_path
  end

  def view
    @course_request = CourseRequest.find(params[:request])
  end

  # Faculty side

  def faculty_index
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    @courses = @user.courses.all
  end

  def publish
    course1 = Course.find(params[:course])
    Course.find(params[:course]).update(published: true)
    for id in Course.find(params[:course]).cross_listing do
      Course.find(id).update(published: true)
      Course.find(id).questions << Course.find(params[:course]).questions
      # Course.find(id).prereqs << Course.find(params[:course]).prereqs
    end
    for course in Course.where(department: course1.department, course_number: course1.course_number) do
      course.update(published: true)
      if course.questions.length == 0
        course.questions << course1.questions
      end
    end
    redirect_to faculty_page_path
  end

  def facreqview
    @course = Course.find(params[:course])
  end

  def deny
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    req = CourseRequest.find(params[:request])
    course = CourseRequest.find(params[:request]).course
    CourseRequest.find(params[:request]).update(status: "Denied")
    # UserMailer.with(user: req.user, request: req).status_changed.deliver_now
    if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
    else
      redirect_to requests_page_path(course)
    end
  end

  def accept
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    course = CourseRequest.find(params[:request]).course
    req = CourseRequest.find(params[:request])
    if course.permission_numbers.where(used: false).count == 0
      redirect_to add_permnum_path(req)
    else
      req.update(status: "Accepted")
      course.increment!(:seats_taken)
      if course.seats_taken >= course.capacity
        # UserMailer.with(user: req.user, course: course).capacity_reached.deliver_now
      end
      perm = course.permission_numbers.where(used: false).last
      perm.course_request = req
      perm.update(used: true)
      # UserMailer.with(user: req.user, request: req).status_changed.deliver_now
      if course.primary == false
        redirect_to requests_page_path(course.cross_listing[0])
      else
        redirect_to requests_page_path(course)
      end
    end
  end

  def addpermnum
    @request = CourseRequest.find(params[:req])
    @course = @request.course
  end

  def add
    course = CourseRequest.find(params[:request]).course
    file = params[:file]
    @request = CourseRequest.find(params[:request])
    CSV.foreach(file, :headers => true) do |row|
      unless row[0] == nil
        course.permission_numbers.create(number: row[0], expire_date: row[7], used: false)
      end
    end  
    redirect_to accept_path(@request) 
  end

end
