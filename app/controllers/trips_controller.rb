class TripsController < ApplicationController

  before_filter :require_login

  def ensure_ownership(trip)
    if trip.user_id != current_user.id
      raise "Trip #{trip.id} does not exist for this user" 
    else
      set_current_trip(trip.id)
    end
  end

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.where(user_id: current_user.id)
    reset_current_trip

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    ensure_ownership @trip

    @routes = @trip.routes.order('seq_no ASC')
    @first_place_id = @routes.first.nil? ? nil : @routes.first.start_place

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    reset_current_trip
    @trip = Trip.new
    @trip.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
    ensure_ownership @trip

    @places = @trip.base_places.order('seq_no ASC')
    @routes = @trip.routes
  end

  # POST /trips
  # POST /trips.json
  def create
    reset_current_trip
    @trip = Trip.new(params[:trip])
    @trip.user_id = current_user.id
    
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])
    ensure_ownership @trip

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    reset_current_trip
    @trip = Trip.find(params[:id])
    ensure_ownership @trip
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end
end
