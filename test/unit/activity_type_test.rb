require 'test_helper'

class ActivityTypeTest < ActiveSupport::TestCase
  test "should_create_actvity_type" do
    at = ActivityType.create activity_type: "Lodging"
    assert at.valid?
  end

  test "should_not_create_duplicate_activity_type" do
    at = ActivityType.create activity_type: "Lodging"
    assert at.valid?
    at2 = ActivityType.create activity_type: "Lodging"
    assert at2.invalid?
    assert_equal at2.errors["activity_type"], ["has already been taken"]
  end
end
