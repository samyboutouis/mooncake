class DashboardController < ApplicationController
  def index
    @user = $current_user
  end

  def faculty_index
    @user = $current_user
  end
end