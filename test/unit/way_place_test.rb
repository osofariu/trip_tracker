require 'test_helper'

class WayPlaceTest < ActiveSupport::TestCase
  test "should_create_wayplace" do
    wp = WayPlace.create route_id: 1, place_id: 3, name: "stop and see grandma"
    assert wp.valid?
  end

  test "should_not_create_duplicate_way_place" do
    wp1 = WayPlace.create route_id: 1, place_id: 3, name: "stop and see grandma"
    assert wp1.valid?
    wp2 = WayPlace.create route_id: 1, place_id: 3, name: "stop and see the Zoo"
    assert wp2.invalid?
    assert_equal wp2.errors[:place_id], ["has already been taken"]
  end
end
