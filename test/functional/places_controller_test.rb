require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  setup do
    @place = places(:one)
    @user = users(:one)
    @trip = trips(:one)
    setup_auth_for_testing
  end

  test "should get index" do
    session[:trip_id] = @trip.id
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should not get index if no trip id set" do
    assert_raise(RuntimeError, "Shouldn't get here") {
      get :index
    }
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post :create, place: { name: "some_other_nams", trip_id: @trip.id, notes: @place.notes, seq_no: 11}
    end

    assert_redirected_to places_path
  end

  test "should show place" do
    get :show, id: @place
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @place
    assert_response :success
  end

  test "should update place" do
    put :update, id: @place, place: { name: @place.name, notes: @place.notes, trip_id: @trip.id, seq_no: 12}
    assert_redirected_to places_path
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end
end
