class FacreqviewController < ApplicationController 

    # Accept
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
            UserMailer.with(user: req.user, course: course).capacity_reached.deliver_now
          end
          perm = course.permission_numbers.where(used: false).last
          perm.course_request = req
          perm.update(used: true)
          UserMailer.with(user: req.user, request: req).status_changed.deliver_now
          if course.primary == false
            redirect_to requests_page_path(course.cross_listing[0])
          else
            redirect_to requests_page_path(course)
          end
        end
    end

    def accept_selected
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
            if course.permission_numbers.where(used: false).count == 0
              redirect_to add_permnum_path(req)
            else
              req.update(status: "Accepted")
              course.increment!(:seats_taken)
              if course.seats_taken >= course.capacity
                UserMailer.with(user: req.user, course: course).capacity_reached.deliver_now
              end
              perm = course.permission_numbers.where(used: false).last
              perm.course_request = req
              perm.update(used: true)
              UserMailer.with(user: req.user, request: req).status_changed.deliver_now
            end
            
          end
          redirect_to requests_page_path(@course)
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
        UserMailer.with(user: req.user, request: req).status_changed.deliver_now
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
            UserMailer.with(user: req.user, request: req).status_changed.deliver_now
          end
          redirect_to requests_page_path(@course)
        else
          redirect_to requests_page_path(params[:courseid])
        end
    end


    # Add More Permission Numbers
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




    # Custom Mailing

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
        Course.find(id).course_requests.each do |request2|
            UserMailer.with(email: request2.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request2.course.id).email_student.deliver_now
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
        
        else
        redirect_to requests_page_path(params[:courseid])
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