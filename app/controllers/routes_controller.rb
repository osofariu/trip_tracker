class RoutesController < ApplicationController
  before_filter :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    trip_ids = Trip.where(user_id: current_user).each.map {|trip| trip.id}
    @routes = Route.where(trip_id: trip_ids)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routes }
    end
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @route = Route.find(params[:id])

    # make sure this belongs to a trip created by *this* user
    trip = Trip.find(@route.trip_id)
    if (trip.user_id != current_user)
      redirect_to welcome_index_path, notice: "This route cannot be found (you thief)." and return
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @route }
    end
  rescue  ActiveRecord::RecordNotFound
    redirect_to welcome_index_path, notice: "This route cannot be found." and return
    
  end

  # GET /routes/new
  # GET /routes/new.json
  def new
    @route = Route.new
    if params[:trip_id]
      @route.trip_id = params[:trip_id]
    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(params[:route])

    respond_to do |format|
      if @route.save
        if session[:redirect_to]
          format.html { redirect_to session[:redirect_to], notice: 'Route was successfully created.' }
        else
          format.html { redirect_to @route, notice: 'Route was successfully created.' }
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
    @route = Route.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
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
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to routes_url }
      format.json { head :no_content }
    end
  end
end
