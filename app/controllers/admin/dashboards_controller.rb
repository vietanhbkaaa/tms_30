class Admin::DashboardsController < ApplicationController
  before_action :admin_user!
  
  def index
    @users_count = User.count
    @courses_count = Course.count
    @subjects_counts = Subject.count
  end
end
