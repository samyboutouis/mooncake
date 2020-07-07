class UserController < ApplicationController
  def show
      @user = User.find_by(net_id: session[:current_user]["net_id"])

      if User.exists?
        # Tell the UserMailer to send a welcome email after save
        UserMailer.with(email: @user.email).welcome_email.deliver_now
      end
  end
end