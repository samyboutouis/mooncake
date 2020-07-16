class MailingController < ApplicationController 
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
            redirect_to requests_page_path(params[:courseid])
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