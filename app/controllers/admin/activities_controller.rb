class Admin::ActivitiesController < ApplicationController
  before_action :admin_user!
  before_action :init_activity, only: :destroy

  def index
    @activities = Activity.recent.paginate page: params[:page],
      per_page: Settings.activities.per_page
  end

  def destroy
    if @activity.destroy
      flash[:success] = t "views.messages.delete_successfully"
    else
      flash[:danger] = t "views.messages.delete_failed"
    end
    redirect_to admin_activities_path
  end

  private
  def init_activity
    @activity = Activity.find params[:id]
  end
end
