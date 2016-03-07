class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #The helper_method line below allows us to use @current_user in our view files
  helper_method :current_user

  # Authorize is for sending someone to the login page if they aren't logged in 
  #add before_action :authorize to controllers you want to enforce this on
  def authorize
    redirect_to '/sessions/new' unless current_user
  end
  
end
