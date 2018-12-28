require 'test_helper'

class AdminDeleteCustomersTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:razor)
    @admin = users(:nemo)
  end

  test "successful deletion of customer account via search" do
    log_in_as(@admin)
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    assert_select "[action=?]", admin_showcustomer_path, count: 3
    #look with id number
    get admin_showcustomer_path, params: { id:  @user.id }
    assert flash.empty?
    assert_template 'admin/users/show'
    assert_select "a[href=?]", admin_user_path(@user), count: 1 
    get admin_user_url(@user)
    assert_difference 'User.count', -1 do
    delete admin_user_path(@user)
    end
    assert_redirected_to admin_root_url
  end
end
