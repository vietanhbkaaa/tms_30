class Admin::UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page], per_page: Settings.subjects.users.per_page
  end
end
