require 'test_helper'

class WayPlacesControllerTest < ActionController::TestCase
  setup do
    setup_auth_for_testing
    @way_place = way_places(:one)
    @place3 = places(:three)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:way_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create way_place" do
    assert_difference('WayPlace.count') do
      post :create, way_place: { name: @way_place.name, place_id: @place3.id, route_id: @way_place.route_id }
    end

    assert_redirected_to way_place_path(assigns(:way_place))
  end

  test "should show way_place" do
    get :show, id: @way_place
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @way_place
    assert_response :success
  end

  test "should update way_place" do
    put :update, id: @way_place, way_place: { name: @way_place.name, place_id: @way_place.place_id, route_id: @way_place.route_id }
    assert_redirected_to way_place_path(assigns(:way_place))
  end

  test "should destroy way_place" do
    assert_difference('WayPlace.count', -1) do
      delete :destroy, id: @way_place
    end

    assert_redirected_to way_places_path
  end
end
