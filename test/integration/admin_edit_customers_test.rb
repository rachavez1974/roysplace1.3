require 'test_helper'

class AdminEditUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)
    @admin = users(:nemo)
  end

  
  
  test "Editing customer via search when is admin logged in" do
    get admin_login_path
    log_in_as(@admin)
    assert is_logged_in?
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    #Look up user by phone number
    get admin_profile_path, params: { phone_number: "#{@user.phone_number}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    assert_select "a[href=?]", edit_admin_user_path(@user)
    get edit_admin_user_path(@user)
    name = "James"
    email = "jc@gmail.com"
    patch admin_user_path(@user), params: { user:{ first_name: name,
                                             email: email,
                                             password: "",
                                             password_confirmation: ""
                                            }
                                    }

    assert_not flash.empty?
    assert_redirected_to admin_user_url(@user)
    @user.reload
    assert_equal name, @user.first_name
    assert_equal email, @user.email 
  end

  
end
