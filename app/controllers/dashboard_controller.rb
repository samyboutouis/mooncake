class DashboardController < ApplicationController
  def index
    @user = $current_user
  end

  def faculty_index
    @user = $current_user
    @courses = @user.courses.all
  end
end