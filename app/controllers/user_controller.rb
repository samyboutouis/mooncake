class UserController < ApplicationController
  def show
      puts $current_user.id
      puts "*******"

      if User.exists?
        puts "@@@@"
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email.deliver_now
      end
    
  end
end