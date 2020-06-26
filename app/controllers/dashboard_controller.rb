class DashboardController < ApplicationController
  def index
    @user = User.find_by(net_id: $current_user.net_id)
    $course_request = @user.course_requests
  end

  def faculty_index
    @user = $current_user
  end

  def withdraw
    # Answer.destroy(Answer.where(course_request: params[:request]))
    CourseRequest.destroy(params[:request])
    redirect_to root_path
  end

  def view 
    @course_request = CourseRequest.find(params[:request])
  end
end