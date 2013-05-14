class PlacesController < ApplicationController
  before_filter :require_login
  before_filter :set_trip_params

  def proper_ownership?(place=nil)
    if !current_trip?
      flash[:notice] = "Places can only be managed withing the context of a particular trip."
      return false
    end
    if place && place.trip_id != current_trip.id
        flash[:notice] = "This place does not belong to the current trip."
        return false
    end
    return true
  end

  # useful when selecting a trip from list of trip, so we can build it 
  def set_trip_params
    if  params[:trip_id]
      trip_id = params[:trip_id]
      set_current_trip(trip_id)
    else
      trip_id = session[:trip_id]
    end
    #Rails.logger.debug "set_trip_params id: #{trip_id} or #{params[:trip_id]} and name: #{params[:place][:name]}"
    @trip = Trip.find(trip_id)
  end

  def get_places_select(parent_id)
   if parent_id
      parent = Place.find(parent_id)
      places_select = [parent]
    else
      places_select = @trip.major_places.order('seq_no ASC').all
    end
    return places_select
  end

  # GET /places
  # GET /places.json
  def index
    unless proper_ownership?
      redirect_to welcome_index_path
      return
    end
    @trip = current_trip
    session[:return_to] = request.url
    @major_places = @trip.major_places.order('seq_no ASC')
    @routes = @trip.routes.order('seq_no ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
    unless proper_ownership? @place
      redirect_to welcome_index_path
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    Rails.logger.debug "Beginning of new"
    unless proper_ownership?
      redirect_to welcome_index_path
      return
    end
    @place = Place.new
    @trip = current_trip
    if params[:prev_place]
      @prev_place = Place.find(params[:prev_place])
      unless proper_ownership? @prev_place
        redirect_to welcome_index_path
        return
      end
    end
    @parent_id = params[:parent_id]
    @places_select = get_places_select(@parent_id)

    respond_to do |format|
      format.html # { new.html.erb}
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    session[:return_to] = request.referer
    @place = Place.find(params[:id])
    if params[:prev_place]
      @prev_place = Place.find(params[:prev_place])   # this is set for all BUT the first place
      unless proper_ownership? @prev_place
        redirect_to welcome_index_path
        return
      end
    end
    @trip = Trip.find(@place.trip_id)
    @parent_id = params[:parent_id]
    @places_select = get_places_select(@parent_id)
    unless proper_ownership? @place
      redirect_to welcome_index_path
      return
    end
  end

  # POST /places
  # POST /places.json
  def create
    @trip = current_trip
    @place = Place.new(params[:place])
    @parent_id = params[:parent_id]
    @places_select = get_places_select(@parent_id)
    unless proper_ownership? @place
      redirect_to welcome_index_path
      return
    end
   
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

  #PUT /places/1
  #PUT /places/1.json
  def update
    @place = Place.find(params[:id])
    @parent_id = params[:parent_id]
    @places_select = get_places_select(@parent_id)
    unless proper_ownership? @place
      redirect_to welcome_index_path
      return
    end
    @trips = [current_trip]

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to session[:return_to], notice: 'Place was successfully updated.' }
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
      format.html { redirect_to session[:return_to] }
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

  def map_distance
  end
end
