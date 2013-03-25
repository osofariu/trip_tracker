require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  setup do
    setup_auth_for_testing
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end

end
