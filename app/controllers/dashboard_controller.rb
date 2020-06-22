class DashboardController < ApplicationController
  def index
    @user = User.find(14)
  end

  def faculty_index
    @user = User.find(14)
  end
end