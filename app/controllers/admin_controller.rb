class AdminController < ApplicationController
    before_filter :require_login, only: [:index]
    
  def index
  end
end
