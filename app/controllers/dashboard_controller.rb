class DashboardController < ApplicationController
  def index
    @user = User.find_by(net_id: $current_user.net_id)
    $course_request = @user.course_requests
  end

  def faculty_index
    @user = $current_user
  end

  # def delete
  #   puts params[:request]
  # end
end