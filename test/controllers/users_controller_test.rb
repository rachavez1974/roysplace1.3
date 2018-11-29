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
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to customer_login_url
  end

  test "should redirect update when not login" do
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              email: @user.email

                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to customer_login_url
  end

  test "should redirect edit when logged in as a wrong user" do
    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to user_url(@another_user) 
    follow_redirect!   
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url    
  end

  test "should redirect update when logged in as wrong user" do

    log_in_as(@another_user)
    assert_not flash.empty?
    assert_redirected_to user_url(@another_user)
    follow_redirect!   
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              email: @user.email
                                            }
                                    }
    assert flash.empty? 
    assert_redirected_to root_url  
  end

  test "should not allow the admin attribute to be edited via the web" do
      log_in_as(@user)
      assert_not @user.admin?
      patch user_path(@user), params: {
                                      user: { password:              "password",
                                              password_confirmation: "password",
                                              admin: true 
                                            } 
                                      }

      assert_not @user.reload.admin?
    end

    test "redirect delete if user not logged or correct user" do
      assert_no_difference "User.count" do
        delete user_path(@user)
      end
      assert_redirected_to customer_login_url
      
    end

end
