class WelcomeController < ApplicationController
  def index
    session[:trip_id] = nil
    session[:return_to] = request.url
  end
end
