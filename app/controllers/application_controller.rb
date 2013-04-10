class ApplicationController < ActionController::Base
  protect_from_forgery


  #@current_trip = session[:trip_id] ? Trip.find(session[:trip_id]) : nil

  def require_login
    if session[:user_id]
      return true
    else
      redirect_to welcome_index_path, notice: 'Please login to continue.'
      return false
    end
  end

  def current_user?
    session[:user_id] ? true : false
  end
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      raise "Current use is not available"
    end
  end

  def current_trip?
    session[:trip_id] ? true : false
  end

  def current_trip
    if session[:trip_id]
      Trip.find(session[:trip_id])
    else
      raise "Current trip is not assigned"
    end
  end

  def set_current_trip(trip_id)
    session[:trip_id] = trip_id
  end

  def reset_current_trip
    session[:trip_id] = nil
  end
end
