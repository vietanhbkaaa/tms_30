class SubjectsController < ApplicationController
  before_action :init_course, only: [:show, :update]
  before_action :init_user_subject, only: [:show, :update]
  before_action :init_course_subject, only: [:show, :update]
  load_and_authorize_resource :course

  def show
  end

  def update
    if @user_subject.update user_subject_params
      flash[:success] = t "views.messages.update_successfully"
      redirect_to [@course, @user_subject.subject]
    else
      flash[:danger] = t "views.messages.failed"
      render :show
    end
  end

  private
  def init_course
    @course = Course.find params[:course_id]
  end

  def init_user_subject
    @user_subject = UserSubject.find_by user_id: current_user.id,
      subject_id: params[:id]
  end

  def init_course_subject
    @course_subject = CourseSubject.find_by course_id: params[:course_id],
      subject_id: params[:id]
  end

  def user_subject_params
    params.require(:user_subject).permit user_tasks_attributes: [:id, :finished]
  end
end
