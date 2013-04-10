class PlacesController < ApplicationController
  before_filter :require_login

  def ensure_ownership(*opt_place)
    if !current_trip?
      raise "Places can only be managed withing the context of a particular trip."
    end
    if place=opt_place[0]
      if place.trip_id != current_trip.id
        raise "This place does not belong to the current trip."
      end
    end
  end

  # GET /places
  # GET /places.json
  def index
    ensure_ownership
    @trip = current_trip
    @places = @trip.base_places.order('seq_no ASC')
    @routes = @trip.routes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
    ensure_ownership @place

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    ensure_ownership
    @place = Place.new
    @base_id = params[:base_id]
    @trip = current_trip

    respond_to do |format|
      format.html # { new.html.erb}
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
    ensure_ownership @place
    @prev_place = Place.find_by_seq_no(@place.seq_no-1)
    @trip = Trip.find(@place.trip_id)
  end


  # POST /places
  # POST /places.json
  def create
    @trip = current_trip
    @place = Place.new(params[:place])
    ensure_ownership @place

    # creating a place and associating it to a route
    if place_kind = params[:place_kind] && route_id = params[:route_id]
      route = Route.find(route_id)
      @place.way_places.build(route_id: route.id, place_kind: @place_kind)
     end

    # adding a new place from edit_parts, so let's create a route
    if last_place = session[:last_place]
      route = Route.create(trip_id: current_trip.id)
      WayPlace.create(place_kind: "start_place", place_id: last_place, route_id: route.id)

      # skip validation because wayplace requires place_id for validation, which doesn't exist.
      to_validate = true
      if @place.valid?
        to_validate=false
      end
      @place.way_places.build(place_kind: "end_place", route_id: route.id)
      session[:last_place] = nil
    end

    respond_to do |format|
      if @place.save(validate: to_validate)
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
    if current_trip?
      @trips = [current_trip]
    else
      @trips = current_user.trips.all
    end
    # need to put this place on a route through way_place
    if @place_kind = params[:place_kind] && @route_id = params[:route_id]
      route = Route.find(@route_id)
      # updating a place with existing way_place
      if (wp=route.way_places.find_by_place_kind(@place_kind))
        wp.destroy # don't need old connection
      end
      @place.way_places << WayPlace.new(route_id: @route_id, place_kind: @place_kind)
    end

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
