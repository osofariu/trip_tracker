require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  test "should_create_activity" do
    act = Activity.create activity_type: "1", name: "Saddleback Bute", cost: 15, notes: "best campground"
    assert act.valid?
  end

  test "should_not_create_duplicate_activity" do
    act = Activity.create activity_type: "1", name: "Saddleback Bute", cost: 15, notes: "best campground"
    assert act.valid?
    act2 = Activity.create activity_type: "1", name: "Saddleback Bute", cost: 15, notes: "best campground"
    assert act2.invalid?
    assert_equal act2.errors[:name], ["has already been taken"]
  end
end
