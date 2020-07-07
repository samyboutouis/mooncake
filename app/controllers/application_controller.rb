class ApplicationController < ActionController::Base
    before_action :require_login
    
    private
    
    def require_login
      redirect_to app_login_path unless session[:user_id]
    end

end
