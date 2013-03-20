require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

  test "should_create_place" do
    place = Place.create route_id: 1, name: "At home", notes: "where the grass is green"
    assert place.valid?
  end

  test "should_be_unique" do
    place1 = Place.create route_id: 1, name: "At home", notes: "where the grass is green"
    assert place1.valid?
    place2 = Place.create route_id: 1, name: "At home", notes: "where the grass is green"
    assert place2.invalid?
    assert_equal place2.errors[:name], ["has already been taken"]
  end
end
