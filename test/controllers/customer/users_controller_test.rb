require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)
    @another_user = users(:nemo)
  end

  test "should get new" do
    get customer_signup_path
    assert_response :success
    assert_select "title", full_title("Registration Form")
  end

  test "should redirect edit when not login" do
    get edit_customer_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to customer_login_url
  end

  test "should redirect update when not login" do
    patch customer_user_path(@user), params: { user: { first_name: @user.first_name,
                                              email: @user.email

                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to customer_login_url
  end

  test "should redirect edit when logged in as a wrong user" do
    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@another_user) 
    follow_redirect!   
    get edit_customer_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url    
  end

  test "should redirect edit when user doesn't exist" do
    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@another_user)
    follow_redirect! 
    non_user = User.new(:id => 15)
    get edit_customer_user_path(non_user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@another_user)
    follow_redirect!   
    patch customer_user_path(@user), params: { user: { first_name: @user.first_name,
                                              email: @user.email
                                            }
                                    }
    assert flash.empty? 
    assert_redirected_to root_url  
  end

  test "should redirect update when user doesn't exist" do
    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@another_user)
    follow_redirect! 
    non_user = User.new(:id => 15)  
    patch customer_user_path(non_user), params: { user: { first_name: @user.first_name,
                                              email: @user.email
                                            }
                                    }
    assert flash.empty? 
    assert_redirected_to root_url  
  end


  test "should not allow the admin attribute to be edited via the web" do
      log_in_as(@user)
      assert_not @user.admin?
      patch customer_user_path([:customer, @user]), params: {
                                      user: { password:              "password",
                                              password_confirmation: "password",
                                              admin: true 
                                            } 
                                      }

      assert_not @user.reload.admin?
    end

    test "redirect delete if user not logged in or correct user" do
      assert_no_difference "User.count" do
        delete customer_user_path(@user)
      end
      assert_redirected_to customer_login_url
      
    end

    test "successful deletion of customer account" do
      log_in_as(@user)
      get customer_user_url(@user)
      assert_template 'customer/users/show'
      assert_select "a[href=?]", customer_user_path, count: 2
      assert_difference 'User.count', -1 do
      delete customer_user_path(@user)
      end
      assert_redirected_to root_url
    end
end
