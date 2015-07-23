class UsersController < ApplicationController
  before_action :init, only: :show

  private
  def init
    @user = User.find params[:id]
  end
end
