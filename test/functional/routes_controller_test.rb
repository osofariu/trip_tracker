require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  setup do
    @route = routes(:one)
    @place3 = places(:three)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create route" do
    assert_difference('Route.count') do
      post :create, route: { distance: @route.distance, end_location: @place3.id, notes: @route.notes, start_location: @route.start_location, trip_id: @route.trip_id }
    end

    assert_redirected_to route_path(assigns(:route))
  end

  test "should show route" do
    get :show, id: @route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @route
    assert_response :success
  end

  test "should update route" do
    put :update, id: @route, route: { distance: @route.distance, end_location: @route.end_location, notes: @route.notes, start_location: @route.start_location, trip_id: @route.trip_id }
    assert_redirected_to route_path(assigns(:route))
  end

  test "should destroy route" do
    assert_difference('Route.count', -1) do
      delete :destroy, id: @route
    end

    assert_redirected_to routes_path
  end
end
