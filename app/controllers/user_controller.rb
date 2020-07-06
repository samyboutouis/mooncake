class UserController < ApplicationController
  # skip_before_action :faculty_check
  # skip_before_action :student_check
  
  def show
      @user = User.find_by(net_id: session[:current_user]["net_id"])

      if User.exists?
        # Tell the UserMailer to send a welcome email after save
        # UserMailer.with(user: @user).welcome_email.deliver_now
      end
  end
end