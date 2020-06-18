class ApplicationController < ActionController::Base
    before_action :require_login
    
    private
    
    def require_login
      redirect_to('http://localhost:3000/oauth/login') unless session[:user_id]
    end

end
