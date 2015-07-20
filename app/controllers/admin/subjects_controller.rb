class Admin::SubjectsController < ApplicationController
  def index
    @subjects = Subject.recent.paginate page: params[:page],
      per_page: Settings.subjects.per_page
  end

  def new
    @subject = Subject.new
    @task = @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "views.messages.create_successfully"
      redirect_to admin_subjects_path
    else
      @task = @subject.tasks.build
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :date_duration,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end
end
