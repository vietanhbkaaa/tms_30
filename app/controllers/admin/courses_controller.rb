class Admin::CoursesController < ApplicationController
  before_action :init_course, only: [:destroy]

  def index
    @courses = Course.recent.paginate page: params[:page],
      per_page: Settings.courses.per_page
  end

  def destroy
    if @course.destroy
      flash[:success] = t "views.messages.delete_successfully"
    else
      flash[:danger] = t "views.messages.delete_failed"
    end
    redirect_to admin_courses_path
  end

  private
  def init_course
    @course = Course.find params[:id]
  end
end
