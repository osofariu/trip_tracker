require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "successfully_create_user" do
    user = User.create name: "testuser1", password: "pass123", password_confirmation: "pass123"
    assert user.valid? 
  end

  test "should_be_unique" do
    user1 = User.create name: "testuser1", password: "pass123", password_confirmation: "pass123"
    user2 = User.create name: "testuser1", password: "pass1234", password_confirmation: "pass1234"
    assert user1.valid?
    assert user2.invalid?
    assert_equal ["has already been taken"], user2.errors[:name]
  end

  test "password_and_password_confirmation_dont_match" do
    user = User.create name: "tester1", password: "pass", password_confirmation: "not_the_same"
    assert user.invalid?
    assert_equal ["doesn't match confirmation"], user.errors[:password]
  end

  test "max_length_name" do
    user = User.create name: "01234567890123456789012345678901234567890", password: "01234567890123456789012345678901234567890", password_confirmation: "01234567890123456789012345678901234567890"
    assert user.invalid? 
    assert_equal ["is too long (maximum is 40 characters)"], user.errors["name"]
    assert_equal ["is too long (maximum is 40 characters)"], user.errors["password"]
    assert_equal ["is too long (maximum is 40 characters)"], user.errors["password_confirmation"]
  end
end
