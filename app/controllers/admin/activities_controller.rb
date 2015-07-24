class Admin::ActivitiesController < ApplicationController
  def index
    @activities = Activity.paginate page: params[:page]
  end

  def destroy
    Activity.find(params[:id]).destroy
    flash[:success] = t "views.messages.delete_successfully"
    redirect_to admin_activities_path
  end
end
