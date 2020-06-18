class DashboardController < ApplicationController
  def index
    @user = User.find(47)
  end
end