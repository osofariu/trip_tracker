require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  setup do
    @route = routes(:one)
    @place3 = places(:three)
  end

  test "should get index" do
    setup_auth_for_testing
    get :index
    assert_response :success
    assert_not_nil assigns(:routes)
  end

 test "should not get index no session" do
    get :index
    assert_redirected_to welcome_index_path
  end

  test "should get new" do
    setup_auth_for_testing
    get :new
    assert_response :success
  end

  test "should not get new no session" do
    get :new
    assert_redirected_to welcome_index_path
  end

  test "should create route" do
    setup_auth_for_testing
    assert_difference('Route.count') do
      post :create, route: { distance: @route.distance, end_place: @place3.id, notes: @route.notes, start_place: @route.start_place, trip_id: @route.trip_id }
    end
    assert_redirected_to route_path(assigns(:route))
  end

  test "should not create route no session" do
    assert_no_difference('Route.count') do
      post :create, route: { distance: @route.distance, end_place: @place3.id, notes: @route.notes, start_place: @route.start_place, trip_id: @route.trip_id }
    end
    assert_redirected_to welcome_index_path
  end

  test "should show route" do
    setup_auth_for_testing
    get :show, id: @route
    assert_response :success
  end

  test "should not show route no session" do
    get :show, id: @route
    assert_redirected_to welcome_index_path
  end

  test "should get edit" do
    setup_auth_for_testing
    get :edit, id: @route
    assert_response :success
  end

  test "should not get edit no session" do
    get :edit, id: @route
    assert_redirected_to welcome_index_path
  end

  test "should update route" do
    setup_auth_for_testing
    put :update, id: @route, route: { distance: @route.distance, end_place: @route.end_place, notes: @route.notes, start_place: @route.start_place, trip_id: @route.trip_id }
    assert_redirected_to route_path(assigns(:route))
  end

    test "should not update route no session" do
    put :update, id: @route, route: { distance: @route.distance, end_place: @route.end_place, notes: @route.notes, start_place: @route.start_place, trip_id: @route.trip_id }
    assert_redirected_to welcome_index_path
  end

  test "should destroy route" do
    setup_auth_for_testing
    assert_difference('Route.count', -1) do
      delete :destroy, id: @route
    end

    assert_redirected_to routes_path
  end

    test "should not destroy route no session" do
    assert_no_difference('Route.count', -1) do
      delete :destroy, id: @route
    end

    assert_redirected_to welcome_index_path
  end
end
