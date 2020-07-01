class UserMailer < ApplicationMailer
 default from: 'noreply@duke.edu'
 
  def welcome_email
    @email = params[:email]
    @url = "http://localhost:3000"
    mail(to: @email, subject: 'Welcome to My Awesome Site')
  end

  def course_created
      @user = params[:user]
      @course = params[:course]
      @url = "http://localhost:3000/facreqview/" + @course.id.to_s
      mail(to: @user.email, subject: 'New Course Created')
  end
end
