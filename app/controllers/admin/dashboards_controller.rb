class Admin::DashboardsController < ApplicationController
  def index
    @users_count = User.count
    @courses_count = Course.count
    @subjects_counts = Subject.count
  end
end
