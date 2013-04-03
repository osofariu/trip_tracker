require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

  test "should_create_place" do
    trip_id = trips(:one).id
    place = Place.create name: "At home", notes: "where the grass is green", trip_id: trip_id
    assert place.valid?
  end

  test "should_be_unique" do
    trip_id = trips(:one).id
    place1 = Place.create name: "At home", notes: "where the grass is green", trip_id: trip_id
    assert place1.valid?
    place2 = Place.create name: "At home", notes: "where the grass is green", trip_id: trip_id
    assert place2.invalid?
    assert_equal place2.errors[:name], ["has already been taken"]
  end
end
