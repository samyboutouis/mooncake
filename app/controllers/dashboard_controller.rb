class DashboardController < ApplicationController
  def index
    @user = User.find(31)
  end
end