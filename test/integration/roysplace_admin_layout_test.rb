require 'test_helper'

class RoysplaceAdminLayoutTest < ActionDispatch::IntegrationTest
  test "test layout links" do
    get admin_dashboard_home_path
    assert_template 'dashboard/home'
    assert_select "a[href=?]", admin_dashboard_home_path, count: 2
    assert_select "a[href=?]", admin_signup_path, count: 1
    assert_select "a[href=?]", admin_login_path, count: 1
    # assert_select "a[href=?]", contact_path, count: 2
    # assert_select "a[href=?]", about_path
    # assert_select "a[href=?]", bagged_path
    # assert_select "a[href=?]", offers_path
    # assert_select "a[href=?]", customer_signup_path
  end
end
