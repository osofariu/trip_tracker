require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  setup do
    @place = places(:one)
    @user = users(:one)
    @trip = trips(:one)
    setup_auth_for_testing
  end

  def set_current_trip(trip_id)
    session[:trip_id] = trip_id
  end

  test "should get index" do
    set_current_trip(@trip.id)
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should not get index if no trip id set" do
    assert_raise(RuntimeError, "This place does not belong to the current trip.") {
      get :index
    }
  end

  test "should get new" do
    set_current_trip(@trip.id)
    get :new
    assert_response :success
  end

  test "should create place" do
    set_current_trip (@trip)
    assert_difference('Place.count') do
      post :create, place: { name: "some_other_nams", trip_id: @trip.id, notes: @place.notes, seq_no: 11}
    end

    assert_redirected_to places_path
  end

  test "should show place" do
    set_current_trip(@trip.id)
    get :show, id: @place
    assert_response :success
  end

  test "should get edit" do
    set_current_trip(@trip.id)
    get :edit, id: @place
    assert_response :success
  end

  test "should update place" do
    set_current_trip(@trip.id)
    set_current_trip(@trip.id)
    put :update, id: @place, place: { name: @place.name, notes: @place.notes, trip_id: @trip.id, seq_no: 12}
    assert_redirected_to places_path
  end

  test "should destroy place" do
    set_current_trip(@trip.id)
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end
end
