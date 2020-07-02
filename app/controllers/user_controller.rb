class UserController < ApplicationController
  def show
      @user = $current_user

      if User.exists?
        # Tell the UserMailer to send a welcome email after save
        # UserMailer.with(user: @user).welcome_email.deliver_now
      end
  end
end