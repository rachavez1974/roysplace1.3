require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_signup_path
    assert_response :success
    assert_select "title", full_title("Registration Form")
  end

end
