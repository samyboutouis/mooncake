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
    xlsx = Roo::Spreadsheet.open(file)
      sheet = xlsx.sheet(0)
      z=0
      sheet.each do |row|
        if z>0
          unless row[0] == nil
            consent = false
            reqs = false
            capacity = false
            if row[8] == "Y"
              capacity = true
            end
            if row[9] == "Y"
              reqs = true
            end
            if row[10] == "Y"
              consent = true
            end
            course.permission_numbers.create(number: row[0].to_i, expire_date: row[7], used: false, consent: consent, capacity: capacity, reqs: reqs)
          end
        end
        z += 1
      end  
    redirect_to accept_path(@request)
  end

  def addmorepermnum
    @course = Course.find(params[:course])
  end

  def addmore
    course = Course.find(params[:course]) #CourseRequest.find(params[:request]).course
    file = params[:file]
    #@request = CourseRequest.find(params[:request])
    xlsx = Roo::Spreadsheet.open(file)
      sheet = xlsx.sheet(0)
      z=0
      sheet.each do |row|
        if z>0
          unless row[0] == nil
            consent = false
            reqs = false
            capacity = false
            if row[8] == "Y"
              capacity = true
            end
            if row[9] == "Y"
              reqs = true
            end
            if row[10] == "Y"
              consent = true
            end
            course.permission_numbers.create(number: row[0].to_i, expire_date: row[7], used: false, consent: consent, capacity: capacity, reqs: reqs)
          end
        end
        z += 1
      end  
    redirect_to numbers_path(course)
  end

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

  def numbers
    @course = Course.find(params[:course])
  end

  def allrequests
    @user = User.find_by(net_id: session[:current_user]["net_id"])
  end

  def denyview
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    req = CourseRequest.find(params[:request])
    course = CourseRequest.find(params[:request]).course
    CourseRequest.find(params[:request]).update(status: "Denied")
    # UserMailer.with(user: req.user, request: req).status_changed.deliver_now
    
    redirect_to allrequests_path(course)
  end

  def acceptview
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
      redirect_to allrequests_path(course)
    end
  end

  def mailing
    @course = CourseRequest.find(params[:request]).course
    req = CourseRequest.find(params[:request])
    @user = req.user
  end

  def mailing2
    course = Course.find(params[:course])
    @sender = User.find_by(net_id: session[:current_user]["net_id"])
    UserMailer.with(email: params[:email], subject: params[:subject], body: params[:body], sender: @sender, course: params[:course]).email_student.deliver_now
    if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
    else
      redirect_to requests_page_path(course)
    end
  end

  def mailingall
    @course = Course.find(params[:course])
  end
  
  def mailingall2
    @course = Course.find(params[:courseid])
    @sender = User.find_by(net_id: session[:current_user]["net_id"])
    @course.course_requests.each  do |request|
      UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: params[:courseid]).email_student.deliver_now
    end
    @course.cross_listing.each do |id|
      Course.find(id).course_requests.each do |request|
        UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
      end
    end
    
    if @course.primary == false
      redirect_to requests_page_path(@course.cross_listing[0])
    else
      redirect_to requests_page_path(@course)
    end
  end

  def reqmailingall
  end
  
  def reqmailingall2
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    @user.courses.each do |course|
      puts course.department
      course.course_requests.each  do |request|
        UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: course.id).email_student.deliver_now
        if course.primary == true
          course.cross_listing.each do |id|
            Course.find(id).course_requests.each do |request|
              puts Course.find(id).department
              UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
            end
          end
        end
      end
    end
    redirect_to allrequests_path
  end

  def mailselected 
    @selected = (params[:selected]).join("~")
    course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
    if course.primary == false
      @course = Course.find(course.cross_listing[0])
    else
      @course = course
    end
  end

  def mailselected2
    @course = Course.find(params[:courseid])
    for req in (params[:selected]).split("~") do
      request = CourseRequest.find(req)
      UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
    end
    redirect_to requests_page_path(@course)
  end

end
