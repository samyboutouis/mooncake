class ApplicationController < ActionController::Base
    before_action :require_login
    before_action :faculty_check
    before_action :student_check

    private
    
    def require_login
      redirect_to('http://localhost:3000/oauth/login') unless session[:user_id]
    end

    def faculty_check
      if session[:current_user]["user_type"] == "student"
        redirect_to student_show_url
      end
    end  

    def student_check
      if session[:current_user]["user_type"] == "student"
        redirect_to faq_path
      end
    end  

end
