require 'test_helper'

class AdminDeleteCustomersTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:razor)
    @admin = users(:nemo)
  end

  test "successful deletion of customer account" do
      log_in_as(@admin)
      get admin_user_url(@user)
      assert_template 'admin/users/show'
      assert_select "a[href=?]", admin_user_path, count: 1
      assert_difference 'User.count', -1 do
      delete admin_user_path(@user)
      end
      assert_redirected_to admin_dashboard_home_url
    end
end
