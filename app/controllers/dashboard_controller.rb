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
    # course1 = Course.find(params[:course])
    # Course.find(params[:course]).update(published: true)
    # for id in Course.find(params[:course]).cross_listing do
    #   Course.find(id).update(published: true)
    #   Course.find(id).questions << Course.find(params[:course]).questions
    #   # Course.find(id).prereqs << Course.find(params[:course]).prereqs
    # end
    # for course in Course.where(department: course1.department, course_number: course1.course_number) do
    #   course.update(published: true)
    #   if course.questions.length == 0
    #     course.questions << course1.questions
    #   end
    # end
    course1 = Course.find(params[:course])
    for course in Course.where(term: course1.term, department: course1.department, course_number: course1.course_number) do
      course.update(published: true)
      for id in course.cross_listing do
        Course.find(id).update(published: true)
        Course.find(id).questions << Course.find(params[:course]).questions
      end
      if course.questions.length == 0
        course.questions << course1.questions
      end
    end      
    redirect_to faculty_page_path
  end


  def add_user
    @course = Course.find(params[:course])
  end

  def add_user2
    @course = Course.find(params[:course])
    newuser = User.find_by(net_id: params[:netid])
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    newuser.courses << @course
    redirect_to faculty_page_path
    UserMailer.with(email: newuser.email, user: @user.id, course: @course.id).shared_course.deliver_now
  end


  # Facreqview Controller
  def facreqview
    @course = Course.find(params[:course])
  end

  # Allrequest Controller
  def allrequests
    @user = User.find_by(net_id: session[:current_user]["net_id"])
  end

  
  #Ranking
  def rank1
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    course = CourseRequest.find(params[:request]).course
    req = CourseRequest.find(params[:request])
    req.update(priority: 1)
    puts req.priority
    if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
    else
      redirect_to requests_page_path(course)
    end

  end

  def rank2
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    course = CourseRequest.find(params[:request]).course
    req = CourseRequest.find(params[:request])
    req.update(priority: 2)
    if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
    else
      redirect_to requests_page_path(course)
    end
  end

  def rank3
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    course = CourseRequest.find(params[:request]).course
    req = CourseRequest.find(params[:request])
    req.update(priority: 3)
    if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
    else
      redirect_to requests_page_path(course)
    end
  end

end
