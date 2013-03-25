class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    if session[:user_id]
      return true
    else
      redirect_to welcome_index_path, notice: 'Please login to continue'
      return false
    end
  end
  
  def current_user
    session[:user_id]
  end

end
