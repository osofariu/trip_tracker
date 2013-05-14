require 'spec_helper'

describe PlacesController do
  before(:each) do
    @place = build(:place)
    @user = @place.trip.user
    session[:user_id] = @user.id         # set current user
    session[:trip_id] = @place.trip_id   # set current trip
  end

  describe "POST create" do
    it "creates a new place" do
      expect {
        post :create, place: {name: @place.name, trip_id: @place.trip_id}
      }.to change(Place, :count).by(1)
    end

    it "redirects to places page after successful save" do
      post :create, place: {name: @place.name, trip_id: @place.trip_id}
      response.should redirect_to(action: 'index')
    end

    it "redirects to edit page with invalid name" do
      @place.name=""
      expect {
        post :create, place: {name: @place.name, trip_id: @place.trip_id}
      }.to_not change(Place, :count).by(1)
    end
    it "redirects to edit page with invalid trip" do
      @place.trip_id=""
      expect {
        post :create, place: {name: @place.name, trip_id: @place.trip_id}
      }.to_not change(Place, :count).by(1)
    end
  end
end
