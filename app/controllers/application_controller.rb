class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  helper_method :is_admin?
  def is_admin?
    return user_signed_in? && current_user.admin
  end

end
