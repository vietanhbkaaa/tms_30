class Admin::UsersController < ApplicationController
  before_action :init_user, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.messages.update_successfully"
    else
      render :edit
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t "views.messages.delete_successfully"
    else
      flash[:danger] = t "views.messages.destroy_unsuccess"
    end
    redirect_to admin_users_path
  end

  private
  def init_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar, :admin
  end
end
