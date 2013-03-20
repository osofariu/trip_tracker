require 'test_helper'

class TripTest < ActiveSupport::TestCase

  test "shold_create_new_trip" do
    trip = Trip.create name: "Hollywood", user_id: 1, description: "trip"
    assert trip.valid?
  end
  
  test "should_be_unique_per_user" do
    trip1 = Trip.create name: "Hollywood", user_id: 1, description: "trip"
    assert trip1.valid?
    trip2 = Trip.create name: "Hollywood", user_id: 1, description: "trip"
    assert trip2.invalid?
    assert_equal trip2.errors[:name], ["has already been taken"]
  end

  test "same_name_okay_for_other_user" do
    trip1 = Trip.create name: "Hollywood", user_id: 1, description: "trip"
    assert trip1.valid?
    trip2 = Trip.create name: "Hollywood", user_id: 2, description: "trip"
    assert trip2.valid?
  end

  test "maximum_name_length" do
     trip1 = Trip.create name: "01234567890123456789012345678901234567890", user_id: 1, description: "trip"
     assert trip1.invalid?
     assert_equal trip1.errors[:name], ["is too long (maximum is 40 characters)"]
   end
end
