class Supervisor::AssignTraineesController < ApplicationController
  before_action :init_course, only: [:edit, :update]
  load_and_authorize_resource :course

  def edit
    @users = User.all
  end

  def update
    if @course.update course_params
      flash[:success] = t "views.messages.update_successfully"
      redirect_to @course
    else
      @users = User.all
      render :edit
    end
  end

  private
  def init_course
    @course = Course.find params[:course_id]
  end

  def course_params
    params.require(:course).permit user_ids: []
  end
end
