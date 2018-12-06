require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get admin_dashboard_home_url
    assert_response :success
  end

end
