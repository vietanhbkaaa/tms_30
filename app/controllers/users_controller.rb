class UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit, :update]
  before_action :check_classmate, only: :show

  def show
    @courses = @current_user.courses.paginate page: params[:page]
    @activities = @user.activities.paginate page: params[:page]
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.messages.update_successfully"
    else
      render :edit
    end
    redirect_to @user
  end

  private
  def init_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :password,
      :password_confirmation, :avatar
  end

  def check_classmate
    if current_user.courses.nil?
      @course = Course.find_by(current_user.courses.last.id)
      unless @course.users.include?(@user)
        redirect_to root_path
        flash[:danger] = t "views.messages.not_permission"
      end
    end
  end
end
