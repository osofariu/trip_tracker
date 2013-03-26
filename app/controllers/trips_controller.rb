class TripsController < ApplicationController

  before_filter :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.where(user_id: session[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    if @trip.user_id != session[:user_id]
      raise "Trip #{params[:id]} does not exist for this user" if !@trip 
    end

    @routes = Route.where(trip_id: @trip.id)
    @first_route = @routes.first
    @last_route =  @routes.last
    @user_name = User.find(@trip.user_id).name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
    rescue  ActiveRecord::RecordNotFound
    redirect_to welcome_index_path, notice: "This trip cannot be found." and return
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new
    @trip.user_id = session[:user_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])
    @trip.user_id = session[:user_id]

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
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end
end
