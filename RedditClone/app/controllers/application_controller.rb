class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :require_loggin!
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_loggin!
    redirect_to new_session_url unless logged_in?
  end
  
  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end
  
  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end
  
end
