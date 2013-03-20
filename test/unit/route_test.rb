require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  test "should_create_route" do
    route = Route.create trip_id: 1, start_location: 1, end_location: 3, distance: 100, notes: "about this route"
    rt =  Route.where start_location: 1, end_location: 3
    assert route.valid?
  end

  test "should_create_multiple_different_route" do
    route1 = Route.create trip_id: 1, start_location: 1, end_location: 3, distance: 100, notes: "about this route"
    assert route1.valid?
    route2 = Route.create trip_id: 1, start_location: 3, end_location: 1, distance: 100, notes: "about this route"
    assert route2.valid?
  end

  test "should_not_create_duplicate_route" do
    route1 = Route.create trip_id: 1, start_location: 1, end_location: 3, distance: 100, notes: "about this route"
    route2 = Route.create trip_id: 1, start_location: 1, end_location: 3, distance: 100, notes: "about this route"
    assert route2.invalid?
    assert_equal route2.errors[:start_location], ["must have unique route between two places"]
  end
end
