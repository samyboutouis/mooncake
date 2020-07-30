class DashboardController < ApplicationController
  skip_before_action :faculty_check, only: [:index, :withdraw, :view, :secret]
  skip_before_action :student_check, only: [:faculty_index, :facreqview, :deny, :addpermnum, :accept, :add, :secret, :publish, :add_user, :add_user2, :allrequests, :searchNetID]#last one?
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
    netid = params[:netid]

    if User.exists?(net_id: netid)
      newuser = User.find_by(net_id: netid)
      @user = User.find_by(net_id: session[:current_user]["net_id"])
      newuser.courses << @course
      newuser.user_type = "faculty"
      redirect_to faculty_page_path
      UserMailer.with(email: newuser.email, user: @user.id, course: @course.id).shared_course.deliver_now
    else
      @user = User.find_by(net_id: session[:current_user]["net_id"])
      searchNetID(@course, netid)
      new_user = User.find_by(net_id: netid)
      redirect_to faculty_page_path
      UserMailer.with(email: new_user.email, user: @user.id, course: @course.id).shared_course.deliver_now
    end
  end


  def searchNetID(course, netid)
    ldap = Net::LDAP.new
    ldap.host = "ldap.duke.edu"
    base = "dc=duke,dc=edu"
    ldap.port = 389

    filter = Net::LDAP::Filter.eq( "uid", netid )

    result = ldap.search( :base => base, :filter => filter )
    ldap.get_operation_result
    information = result.pop

    affiliation = information["edupersonprimaryaffiliation"].join(' ')
    grad_year = information["dupsexpgradtermc1"].join(' ')
    email = information["edupersonprincipalname"].join(' ')
    first_name = information["givenname"].join(" ")
    last_name = information["sn"].join(' ')
    unique_id = information['dudukeid'].join(' ')

    newuser = User.create(first_name: first_name, last_name: last_name, net_id: netid, unique_id: unique_id, email: email, net_id: netid, grad_year: grad_year, user_type: affiliation)

    newuser.courses << course
    newuser.user_type = "faculty"

  end

  # Facreqview Controller
  def facreqview
    @course = Course.find(params[:course])
  end

  # Allrequest Controller
  def allrequests
    @user = User.find_by(net_id: session[:current_user]["net_id"])
  end

  def secret
  end


end
