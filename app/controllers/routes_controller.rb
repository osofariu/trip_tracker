class RoutesController < ApplicationController
  before_filter :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_filter :find_trip

private 

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

public

  # GET /routes
  # GET /routes.json
  def index
    @routes = @trip.routes.all
    respond_to do |format|
      if @trip.user_id != current_user 
        redirect_to welcome_index_path, notice: "This route cannot be found." and return
      else
        format.html # index.html.erb
      end
      format.json { render json: @routes }
    end
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @route = @trip.routes.find(params[:id])

    if (@trip.user_id != current_user)
      redirect_to welcome_index_path, notice: "This route cannot be found (you thief)." and return
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = @trip.routes.new
    if params[:trip_id]
      @route.trip_id = params[:trip_id]
    end 
    logger.debug "routes/new id: (#{@route.id})."
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
    logger.debug "Route with ID= #{@route.id}"
      
    start_p = Route.get_route_places(@route.id, "start_place")
    if start_p
      @def_start_place_id = Route.get_route_places(@route.id, "start_place").id
    end

    end_p = Route.get_route_places(@route.id, "end_place")
    if end_p
      @def_end_place_id   = Route.get_route_places(@route.id, "end_place").id
    end

    logger.debug "start_p_id: #{@def_start_place_id} and end_p: #{@def_end_place_id}"
    logger.flush
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = @trip.routes.new(params[:route])

    respond_to do |format|
      if @route.save
        if session[:redirect_to]
          format.html { redirect_to session[:redirect_to], notice: 'Route was successfully created.' }
        else
          format.html { redirect_to trip_routes_path(@route.trip_id), notice: 'Route was successfully created.' }
        end
        format.json { render json: @route, status: :created, location: @route }
      else
        format.html { render action: "new" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /routes/1
  # PUT /routes/1.json
  def update
    @route = @trip.routes.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html { redirect_to [@trip, @route], notice: 'Route was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route = @trip.routes.find(params[:id])
    @route.destroy 

    respond_to do |format|
      format.html { redirect_to trip_routes_path(@trip) }
      format.json { head :no_content }
    end
  end
end
