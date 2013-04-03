require 'test_helper'

class WayPlaceTest < ActiveSupport::TestCase
  test "should_create_wayplace" do
    wp = WayPlace.create route_id: 2, place_id: 3, place_kind: "way_place"
    assert wp.valid?
  end

  test "should_not_create_duplicate_way_place_start" do
    wp1 = WayPlace.create route_id: 2, place_id: 3, place_kind: "start_place"
    assert wp1.valid?
    wp2 = WayPlace.create route_id: 2, place_id: 3, place_kind: "start_place"
    assert wp2.invalid?
    assert_equal wp2.errors[:place_kind], ["You cannot start more than one routes from the same place."]
  end

  test "should_not_create_duplicate_way_place_end" do
    wp1 = WayPlace.create route_id: 2, place_id: 3, place_kind: "end_place"
    assert wp1.valid?
    wp2 = WayPlace.create route_id: 2, place_id: 3, place_kind: "end_place"
    assert wp2.invalid?
    assert_equal wp2.errors[:place_kind], ["You cannot end more than one route at the same place."]
  end
end
