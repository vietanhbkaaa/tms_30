class Supervisor::CoursesController < ApplicationController
  before_action :init_course, except: [:index, :new, :create]
  load_and_authorize_resource :course
  
  def index
    @courses = current_user.managing_courses.paginate page: params[:page],
      per_page: Settings.courses.per_page
  end

  def show
  end

  def edit
  end

  def update
    if @course.update course_params
      flash[:success] = t "views.messages.update_successfully"
    else
      flash[:danger] = t "views.messages.update_failed"
    end
    redirect_to [:supervisor, @course]
  end

  def destroy
    if @course.destroy
      flash[:success] = t "views.messages.delete_successfully"
    else
      flash[:danger] = t "views.messages.delete_failed"
    end
    redirect_to supervisor_courses_path
  end
  
  private
  def init_course
    @course = Course.find params[:id]
  end

  def course_params
    params.require(:course).permit :name, :description, :closed
  end
end
