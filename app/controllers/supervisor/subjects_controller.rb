class Supervisor::SubjectsController < ApplicationController
  before_action :init_course, only: [:edit, :update]
  before_action :init_course_subject, only: [:edit, :update]
  load_and_authorize_resource :course

  def edit
  end

  def update
    if @course_subject.update course_subject_params
      flash[:success] = t "views.messages.update_successfully"
    else
      flash[:danger] = t "views.messages.update_failed"
    end
    redirect_to [:supervisor, @course]
  end

  private
  def init_course
    @course = Course.find params[:course_id]
  end

  def init_course_subject
    @course_subject = CourseSubject.find_by course_id: params[:course_id],
      subject_id: params[:id]
  end

  def course_subject_params
    params.require(:course_subject).permit :closed
  end
end
