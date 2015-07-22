class Admin::UsersController < ApplicationController
  before_action :init_user, only: [:destroy]

  def index
    @users = User.recent.paginate page: params[:page],
      per_page: Settings.subjects.users.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "views.messages.create_successfully"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    if @user = @user.destroy
      flash[:success] = t "views.messages.destroy_success"
    else
      flash[:danger] = t "views.messages.destroy_unsuccess"
    end
    redirect_to admin_users_path
  end

  private
  def init_user
    @user = User.find params[:id]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end
end
