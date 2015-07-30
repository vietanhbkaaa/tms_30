class UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit, :update]

  def show
    @activities = @user.activities.recent.paginate page: params[:page],
      per_page: Settings.activities.per_page
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
end
