class UserMailer < ApplicationMailer
 default from: 'noreply@duke.edu'
 
  def welcome_email
    puts "*****-----*****"
    @user = User.find(1)
    mail(to: "ms858@duke.edu", subject: 'Welcome to My Awesome Site')
  end
end
