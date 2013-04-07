class PlacesController < ApplicationController
  before_filter :require_login

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

    #session[:place_kind] = params[:place_kind] if params[:place_kind]
    #session[:route_id] = params[:route_id] if params[:route_id]
    session[:last_place] = params[:last_place] if params[:last_place]

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
    if session[:trip_id]
      @trips = [Trip.find(session[:trip_id])]
    else
      @trips = User.find(current_user).trips.all
    end
    @place = Place.new(params[:place])
    # validate unless.. need to skit it to save way_places
    to_validate = true

    # creating a place and associating it to a route
    if place_kind = params[:place_kind] && route_id = params[:route_id]
      route = Route.find(route_id)
      @place.way_places.build(route_id: route.id, place_kind: @place_kind)
     end

    # adding a new place from edit_parts, so let's create a route
    if last_place = session[:last_place]
      route = Route.create(trip_id: session[:trip_id])
      WayPlace.create(place_kind: "start_place", place_id: last_place, route_id: route.id)

      if @place.valid?
        to_validate=false
      end
      @place.way_places.build(place_kind: "end_place", route_id: route.id)
      session[:last_place] = nil
    end

    respond_to do |format|
      if @place.save(validate: to_validate)
        if session[:redirect_to]
          format.html { redirect_to session[:redirect_to], notice: 'Place was successfully created.' }
        else
         format.html { redirect_to places_path, notice: 'Place was successfully created.' }
        end

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
    if session[:trip_id]
      @trips = [Trip.find(session[:trip_id])]
    else
      @trips = User.find(current_user).trips.all
    end
    if @place_kind = params[:place_kind] && @route_id = params[:route_id]
      route = Route.find(@route_id)
      # updating a place with existing way_place
      logger.debug "looking for: "
      if (wp=route.way_places.find_by_place_kind(@place_kind))
        wp.destroy
      end
      @place.way_places << WayPlace.new(route_id: @route_id, place_kind: @place_kind)
    end

    respond_to do |format|
      if @place.update_attributes(params[:place])
        if session[:redirect_to]
          format.html { redirect_to session[:redirect_to], notice: 'Place was successfully updated.' }
        else
          format.html { redirect_to places_path, notice: 'Place was successfully updated.' }
        end
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
      if session[:redirect_to]
        format.html { redirect_to session[:redirect_to], notice: 'Place was successfully removed.' }
      else
        format.html { redirect_to places_url }
      end
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
