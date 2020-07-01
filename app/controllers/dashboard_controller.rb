class DashboardController < ApplicationController
  def index
    @user = User.find_by(net_id: $current_user.net_id)
    $course_request = @user.course_requests
  end

  def withdraw
    # Answer.destroy(Answer.where(course_request: params[:request]))
    CourseRequest.destroy(params[:request])
    redirect_to root_path
  end

  def view
    @course_request = CourseRequest.find(params[:request])
  end

  # Faculty side

  def faculty_index
    @user = $current_user
    @courses = @user.courses.all
  end

  def facreqview
    @course = Course.find(params[:course])
  end

  def deny
    course = CourseRequest.find(params[:request]).course
    CourseRequest.find(params[:request]).update(status: "Denied")
    redirect_to requests_page_path(course)
  end

  def accept
    course = CourseRequest.find(params[:request]).course
    CourseRequest.find(params[:request]).update(status: "Accepted")
    redirect_to requests_page_path(course)
  end

end
