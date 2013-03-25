require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  setup do
    setup_auth_for_testing
    @trip = trips(:one)

  end

  test "should get index" do
    post :create, session: {user_id: "tester123", password: "abc123", password_confirmation: "abc123"}
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post :create, trip: { description: @trip.description, name: "#{@trip.name}_1", user_id: @trip.user_id }
      #puts response.body
    end
    
    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should show trip" do
    get :show, id: @trip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip
    assert_response :success
  end

  test "should update trip" do
    put :update, id: @trip, trip: { description: @trip.description, name: "#{@trip.name}_1", user_id: @trip.user_id }
    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete :destroy, id: @trip
    end

    assert_redirected_to trips_path
  end
end
