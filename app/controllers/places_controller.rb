class PlacesController < ApplicationController
  before_filter :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy, :by_name]

  # GET /places
  # GET /places.json
  def index
    logger.info "place_controller#index #{session[:trip_id]}"
    if session[:trip_id]
      @places = Place.where(trip_id: session[:trip_id])
    else
      @places = Place.user_places(current_user)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new
    if session[:trip_id]
      @trips = [ Trip.find(session[:trip_id])]
    else
      @trips = Trip.where(user_id: session[:user_id])
    end
    logger.debug("TRIPS is: #{@trips}")
    logger.flush

    respond_to do |format|
      format.html # { new.html.erb}
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
    @trips = [ Trip.find(@place.trip_id)]
    logger.debug "PLACE in edit has data.. #{@place}"
  end

  def add_activity
    @place = Place.find(params[:id])
  end


  # POST /places
  # POST /places.json
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to places_path, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to places_path, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  def by_name
    @places_match=Array.new
    if params[:name].empty?
      return @places_match
    end
    
    Place.all.each do |place|
      place_pat = Regexp.compile(params[:name])  
      if place_pat =~ place.name
        @places_match << place
      end
    end
  end
end
