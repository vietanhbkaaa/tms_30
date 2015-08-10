class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  def admin_user!
    unless current_user.admin?
      flash[:danger] = t "views.messages.not_permission"
      redirect_to root_path
    end
  end
end
