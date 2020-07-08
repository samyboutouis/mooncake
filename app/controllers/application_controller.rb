class ApplicationController < ActionController::Base
    before_action :require_login
    # before_action :faculty_check
    # before_action :student_check

    private
    
    def require_login
      redirect_to app_login_path unless session[:user_id]
    end

    # def faculty_check
    #   if session[:current_user]["user_type"] == "student"
    #     redirect_to root_path
    #   end
    # end  

    # def student_check
    #   if session[:current_user]["user_type"] == "faculty" || session[:current_user]["user_type"] == "staff"
    #     redirect_to faculty_page_path
    #   end
    # end  

end
