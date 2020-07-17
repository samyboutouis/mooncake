class AllrequestController < ApplicationController

    # Deny
    def denyview
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        req = CourseRequest.find(params[:request])
        
        course = CourseRequest.find(params[:request]).course
        CourseRequest.find(params[:request]).update(status: "Denied")
        CourseRequest.find(params[:request]).permission_number = nil
        UserMailer.with(user: req.user, request: req).status_changed.deliver_now
        redirect_to allrequests_path
    end

    def all_deny_selected
        if params.include?("selected")
            course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
            for id in (params[:selected]) do
              req = CourseRequest.find(id)
              course = req.course
              req.update(status: "Denied")
              req.permission_number = nil
              UserMailer.with(user: req.user, request: req).status_changed.deliver_now
            end
            redirect_to allrequests_path
        else
            redirect_to allrequests_path
        end
    end

    # Accept
    def acceptview
        @user = User.find_by(net_id: session[:current_user]["net_id"])
        course = CourseRequest.find(params[:request]).course
        req = CourseRequest.find(params[:request])
        # #checks if expired, boolean "expired" becomes true
        # datee = []
        # courseunused = course.permission_numbers.where(used: false)
        # for ew in courseunused
        #   datee.append(ew.expire_date)
        # end
        # for numberdate in datee
        #   datetimedate = Date.strptime(numberdate)
        #   if Date.today >= datetimedate #expired
        #     stringnumber = datetimedate.to_s
        #     expiredboi = courseunused.where(expire_date: stringnumber)
        #     for nummm in expiredboi
        #       nummm.expired = true
        #     end
        #   end
        # end
        if (course.permission_numbers.where(used: false).count == 0) #|| (course.permission_numbers.where(expired: false).count == 0)
          redirect_to all_add_permnum_path(req)
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

          redirect_to allrequests_path
        end
    end

    def all_accept_selected
        if params.include?("selected")
            if params[:selected].class == String
              params[:selected] = params[:selected].split("~")
            end
            course = Course.find(CourseRequest.find(params[:selected][0]).course.id)

            reqlist = []
            courselist = []
            coursenames = []
            for id in (params[:selected]) do
              req = CourseRequest.find(id)
              course = req.course
              if req.permission_number != nil
                next
              end
              # #checks if expired, boolean "expired" becomes true
              # datee = []
              # courseunused = course.permission_numbers.where(used: false)
              # for ew in courseunused
              #   datee.append(ew.expire_date)
              # end
              # for numberdate in datee
              #   datetimedate = Date.strptime(numberdate)
              #   if Date.today >= datetimedate #expired
              #     stringnumber = datetimedate.to_s
              #     expiredboi = courseunused.where(expire_date: stringnumber)
              #     for nummm in expiredboi
              #       nummm.expired = true
              #     end
              #   end
              # end
              if (course.permission_numbers.where(used: false).count == 0) #|| (course.permission_numbers.where(expired: false).count == 0)
                reqlist.append(req.id)
                courselist.append(course.id)
                coursenames.append(course.department.split(" ").first + "."+ course.course_number + "-"+ course.section_number)
                next
              end
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
            if reqlist.count == 0
              redirect_to allrequests_path
            else
              selected = reqlist.join("~")
              #courseid = params[:courseid]
              redirect_to all_add_permnum_selected_path(selected)
            end
          else
            redirect_to allrequests_path
          end
      end

     # Add More Permission Numbers

     def all_addpermnumselected
        @selected = params[:selected]
        @course = CourseRequest.find(@selected.split("~").first).course
        #@courseid = params[:courseid]
    end

    def all_add_selected
        @selected = params[:selected]
        #@courseid = params[:courseid]
        course = CourseRequest.find(@selected.split("~").first).course
        file = params[:file]
        file_upload(file, course.id)
    end


     def all_addpermnum
        @request = CourseRequest.find(params[:req])
        @course = @request.course
    end

    def all_add
      course = CourseRequest.find(params[:request]).course
      file = params[:file]
      file_upload(file, course.id)
      redirect_to allrequests_path
  end



    # Custom Mailing
      def reqmailingall
      end

      def reqmailingall2
          @user = User.find_by(net_id: session[:current_user]["net_id"])
          @user.courses.each do |course|
          course.course_requests.each  do |request|
              UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
              if course.primary == true
              course.cross_listing.each do |id|
                  Course.find(id).course_requests.each do |request2|
                  UserMailer.with(email: request2.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request2.course.id).email_student.deliver_now
                  end
              end
              end
          end
          end
          redirect_to allrequests_path
      end



      def allmailselected
          if params.include?("selected")
          @selected = (params[:selected]).join("~")
          course = Course.find(CourseRequest.find(params[:selected][0]).course.id)
          if course.primary == false
              @course = Course.find(course.cross_listing[0])
          else
              @course = course
          end

          else
              redirect_to allrequests_path
          end

      end

      def allmailselected2
          @course = Course.find(params[:courseid])
          for req in (params[:selected]).split("~") do
          request = CourseRequest.find(req)
          UserMailer.with(email: request.user.email, subject: params[:subject], body: params[:body], sender: @sender, course: request.course.id).email_student.deliver_now
          end
          redirect_to allrequests_path
      end
end
