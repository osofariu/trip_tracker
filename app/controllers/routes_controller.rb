class RoutesController < ApplicationController
  before_filter :require_login
  before_filter :find_trip, except: ["get_distance"]

private 

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

public

  # GET /routes
  # GET /routes.json
  def index
    @routes = @trip.routes.order("seq_no ASC")
    session[:return_to] = request.referer
    logger.debug "Saving return address in routes_controller: #{request.referer}"
    respond_to do |format|
      if @trip.user_id != current_user.id
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

    if (@trip.user_id != current_user.id)
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
    @route.trip_id = @trip.id
    @route.distance = calc_distance(route.start_place.name, route.end_place.name)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
    session[:return_to] = request.referer
    logger.debug "Route with ID= #{@route.id}"
      
    start_p = @route.start_place
    if start_p
      @def_start_place_id = start_p.id
    end

    end_p = @route.end_place
    if end_p
      @def_end_place_id   = end_p.id
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
        format.html { redirect_to trip_routes_path, notice: 'Route was successfully created.' }
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
        format.html { redirect_to session[:return_to], notice: 'Route was successfully updated.' }
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
      format.html { redirect_to session[:return_to] }
      format.json { head :no_content }
    end
  end

  def cleanup
    Route.remove_inactive
    respond_to do |format|
      format.html { redirect_to session[:return_to] }
    end
  end

  def get_distance
    @start_place = params[:start_place]
    @end_place = params[:end_place]
  end
end
