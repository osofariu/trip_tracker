class WelcomeController < ApplicationController
  def index
    session[:trip_id] = nil
  end
end
