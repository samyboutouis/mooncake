class FacreqviewController < ApplicationController

    # Accept
    def accept
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        course = CourseRequest.find(params[:request]).course
        req = CourseRequest.find(params[:request])
        #checkexpire(course.id)

        if (course.permission_numbers.where(used: false).count == 0) #|| (course.permission_numbers.where(expired: false).count == 0)
          redirect_to add_permnum_path(req)
        else
          req.update(status: "Accepted")
          course.increment!(:seats_taken)
          if course.seats_taken >= course.capacity
            #UserMailer.with(user: req.user, course: course).capacity_reached.deliver_now
          end
          perm = course.permission_numbers.where(used: false).last
          perm.course_request = req
          perm.update(used: true)
          #UserMailer.with(user: req.user, request: req).status_changed.deliver_now
          if course.primary == false
            redirect_to requests_page_path(course.cross_listing[0])
          else
            redirect_to requests_page_path(course)
          end
        end
    end

    def accept_selected
        if params.include?("selected")

          if params[:selected].class == String
            params[:selected] = params[:selected].split("~")
          end
          course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
          if course.primary == false
              @course = Course.find(course.cross_listing[0])
          else
              @course = course
          end
          reqlist = []
          courselist = []
          coursenames = []
          for id in (params[:selected]) do
            req = CourseRequest.find(id)
            course = req.course
            if req.permission_number != nil
              next
            end
            #checkexpire(course.id)

            if (course.permission_numbers.where(used: false).count == 0) #|| (course.permission_numbers.where(expired: false).count == 0)
              reqlist.append(req.id)
              courselist.append(course.id)
              coursenames.append(course.department.split(" ").first + "."+ course.course_number + "-"+ course.section_number)
              next
            end
            puts "******"
            puts req.id
            puts req.status
            req.update(status: "Accepted")
            puts req.status
            course.increment!(:seats_taken)
            if course.seats_taken >= course.capacity
              #UserMailer.with(user: req.user, course: course).capacity_reached.deliver_now
            end
            perm = course.permission_numbers.where(used: false).last
            perm.course_request = req
            perm.update(used: true)
            #UserMailer.with(user: req.user, request: req).status_changed.deliver_now
          end
          if reqlist.count == 0
            redirect_to requests_page_path(@course)
          else
            selected = reqlist.join("~")
            coursid = params[:courseid]
            redirect_to add_permnum_selected_path(selected, coursid)
          end
        else
          redirect_to requests_page_path(params[:courseid])
        end
    end

    # Deny

    def deny
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        req = CourseRequest.find(params[:request])
        course = CourseRequest.find(params[:request]).course
        CourseRequest.find(params[:request]).update(status: "Denied")
        CourseRequest.find(params[:request]).permission_number = nil
        #UserMailer.with(user: req.user, request: req).status_changed.deliver_now
        if course.primary == false
          redirect_to requests_page_path(course.cross_listing[0])
        else
          redirect_to requests_page_path(course)
        end
      end

    def deny_selected
        if params.include?("selected")
          course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
          if course.primary == false
              @course = Course.find(course.cross_listing[0])
          else
              @course = course
          end
          for id in (params[:selected]) do
            req = CourseRequest.find(id)
            course = req.course
            req.update(status: "Denied")
            req.permission_number = nil
            #UserMailer.with(user: req.user, request: req).status_changed.deliver_now
          end
          redirect_to requests_page_path(@course)
        else
          redirect_to requests_page_path(params[:courseid])
        end
    end


    # Add More Permission Numbers
    def addpermnumselected
        @selected = params[:selected]
        @course = CourseRequest.find(@selected.split("~").first).course
        @courseid = params[:courseid]
    end

    def add_selected
        @selected = params[:selected]
        @courseid = params[:courseid]
        course = CourseRequest.find(@selected.split("~").first).course
        file = params[:file]
        file_upload(file, course.id)
    end

  def addpermnum
      @request = CourseRequest.find(params[:req])
      @course = @request.course

  end

  def add
      course = CourseRequest.find(params[:request]).course
      file = params[:file]
      file_upload(file, course.id)
      redirect_to accept_path(params[:request])
  end




  # Custom Mailing

  def mailing
      @course = CourseRequest.find(params[:request]).course
      req = CourseRequest.find(params[:request])
      @user = req.user
  end

  def mailing2
      course = Course.find(params[:course])
      @sender = User.find_by(net_id: session[:current_user]["net_id"])
      #UserMailer.with(email: params[:email], subject: params[:subject], body: params[:body], sender: @sender, course: params[:course]).email_student.deliver_now
      if course.primary == false
      redirect_to requests_page_path(course.cross_listing[0])
      else
      redirect_to requests_page_path(course)
      end
  end

  def mailingall
      @course = Course.find(params[:course])
      @names = []
      @course.course_requests.each  do |request|
        @names.append(request.user.first_name + " " + request.user.last_name)
      end
      @course.cross_listing.each do |id|
        Course.find(id).course_requests.each do |request2|
          @names.append(request2.user.first_name + " " + request2.user.last_name)
        end
      end
      @names = @names.join(", ")
  end

  def mailingall2
      @course = Course.find(params[:courseid])
      @sender = User.find_by(net_id: session[:current_user]["net_id"])
      @course.course_requests.each  do |request|
      #UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: params[:courseid]).email_student.deliver_now
      end
      @course.cross_listing.each do |id|
      Course.find(id).course_requests.each do |request2|
          #UserMailer.with(email: request2.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request2.course.id).email_student.deliver_now
      end
      end

      if @course.primary == false
      redirect_to requests_page_path(@course.cross_listing[0])
      else
      redirect_to requests_page_path(@course)
      end
  end

  def mailselected
      if params.include?("selected")
        @selected = (params[:selected]).join("~")
        course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
        if course.primary == false
            @course = Course.find(course.cross_listing[0])
        else
            @course = course
        end
        @names = []
        for req in (params[:selected]) do
          request = CourseRequest.find(req)
          @names.append(request.user.first_name + " " + request.user.last_name)
        end
        @names = @names.join(", ")

      else
        redirect_to requests_page_path(params[:courseid])
      end

  end

  def mailselected2
      @course = Course.find(params[:courseid])
      for req in (params[:selected]).split("~") do
      request = CourseRequest.find(req)
      #UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
      end
      redirect_to requests_page_path(@course)
  end
end
