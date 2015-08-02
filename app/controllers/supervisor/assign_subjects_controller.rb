class Supervisor::AssignSubjectsController < ApplicationController
  before_action :init_course, only: [:edit, :update]
  load_and_authorize_resource :course

  def edit
    @subjects = Subject.all
  end

  def update
    if @course.update course_params
      flash[:success] = t "views.messages.update_successfully"
      redirect_to [:supervisor, @course]
    else
      @subjects = Subject.all
      render :edit
    end
  end

  private
  def init_course
    @course = Course.find params[:course_id]
  end

  def course_params
    params.require(:course).permit subject_ids: []
  end
end
