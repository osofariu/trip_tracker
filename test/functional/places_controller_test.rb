require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  setup do
    @place = places(:one)
    @user = users(:one)
    @trip = trips(:one)
    setup_auth_for_testing
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post :create, place: { name: "${@place.name}_2", trip_id: @trip.id, notes: @place.notes}
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
    put :update, id: @place, place: { name: @place.name, notes: @place.notes, trip_id: @trip.id}
    assert_redirected_to places_path
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end
end
