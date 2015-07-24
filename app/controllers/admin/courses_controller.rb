class Admin::CoursesController < ApplicationController
  before_action :init_course, only: [:show, :destroy]

  def new
    @subjects = Subject.all
    @course = Course.new  
  end

  def show
  end

  def new
    @subjects = Subject.all
    @course = Course.new  
  end

  def index
    @courses = Course.recent.paginate page: params[:page],
      per_page: Settings.courses.per_page
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "views.messages.create_successfully"
      redirect_to admin_courses_path
    else
      @subjects = Subject.all
      render :new
    end
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

  private
  def course_params
    params.require(:course).permit :name, :description, subject_ids: []
  end
end
