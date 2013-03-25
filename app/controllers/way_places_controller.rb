class WayPlacesController < ApplicationController
  before_filter :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  
  # GET /way_places
  # GET /way_places.json
  def index
    @way_places = WayPlace.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @way_places }
    end
  end

  # GET /way_places/1
  # GET /way_places/1.json
  def show
    @way_place = WayPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @way_place }
    end
  end

  # GET /way_places/new
  # GET /way_places/new.json
  def new
    @way_place = WayPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @way_place }
    end
  end

  # GET /way_places/1/edit
  def edit
    @way_place = WayPlace.find(params[:id])
  end

  # POST /way_places
  # POST /way_places.json
  def create
    @way_place = WayPlace.new(params[:way_place])

    respond_to do |format|
      if @way_place.save
        format.html { redirect_to @way_place, notice: 'Way place was successfully created.' }
        format.json { render json: @way_place, status: :created, location: @way_place }
      else
        format.html { render action: "new" }
        format.json { render json: @way_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /way_places/1
  # PUT /way_places/1.json
  def update
    @way_place = WayPlace.find(params[:id])

    respond_to do |format|
      if @way_place.update_attributes(params[:way_place])
        format.html { redirect_to @way_place, notice: 'Way place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @way_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /way_places/1
  # DELETE /way_places/1.json
  def destroy
    @way_place = WayPlace.find(params[:id])
    @way_place.destroy

    respond_to do |format|
      format.html { redirect_to way_places_url }
      format.json { head :no_content }
    end
  end
end
