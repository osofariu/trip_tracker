module ApplicationHelper
  def logged_on?
    if session[:user_id]
      return true
    else
      return false
    end
  end

  def get_user
    session[:user_id]
  end
end
