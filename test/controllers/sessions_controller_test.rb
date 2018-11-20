require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new login form for regular user" do
    get customer_signup_path
    assert_response :success
  end

end
