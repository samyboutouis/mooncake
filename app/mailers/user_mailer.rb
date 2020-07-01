class UserMailer < ApplicationMailer
 default from: 'noreply@duke.edu'
 
  def welcome_email
    @email = params[:email]
    @url = "http://localhost:3000"
    mail(to: @email, subject: 'Welcome to Mooncake')
  end

  def course_created
      @user = params[:user]
      @course = params[:course]
      @url = "http://localhost:3000/facreqview/" + @course.id.to_s
      mail(to: @user.email, subject: 'New Course Created')
  end

  def request_submitted 
    @user = params[:user]
    @request = params[:request]
    @course = @request.course
    @url = "http://localhost:3000"
    @url2 = "http://localhost:3000/requestform/" + @request.id.to_s
    mail(to: @user.email, subject: 'Submitted Course Request')
  end

  def status_changed
    @user = params[:user]
    @request = params[:request]
    @course = @request.course
    @url = "http://localhost:3000"
    mail(to: @user.email, subject: 'Request Status Changed')
  end

  def capacity_reached
    @user = params[:user]
    @course = params[:course]
    mail(to: @user.email, subject: 'Course Capacity Reached')
  end 
end
