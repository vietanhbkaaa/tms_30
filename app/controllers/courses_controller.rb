class CoursesController < ApplicationController
  before_action :init_course, only: :show
  load_and_authorize_resource :course

  def show
  end

  private
  def init_course
    @course = Course.find params[:id]
  end
end
