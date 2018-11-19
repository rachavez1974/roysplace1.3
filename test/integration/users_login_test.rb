require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)  
  end

  test "attempting login with wrong credentials" do
    get customer_login_path
    assert_template 'sessions/new_user_session'
    post customer_login_path, params: { session: { email: " ", password: " " } }


    assert_template 'sessions/new_user_session'
    assert_not flash.empty?
    get root_path
    assert flash.empty?

  end

  test "attempting login with right credentials and follow byt logout" do
    get customer_login_path
    assert_select "a[href=?]", customer_login_path, count: 1
    assert_template 'sessions/new_user_session'

    post customer_login_path, params: { session: { email: "razor@gmail.com", password: "password" } }


    assert is_logged_in?
    assert_redirected_to root_path 
    follow_redirect!    
    assert_template 'static_pages/home'
    assert_not flash.empty?
    assert_select 'div.alert', "Welcome back #{@user.first_name}"
    assert_select "a[href=?]", customer_login_path, count: 0
    assert_select "a[href=?]", customer_logout_path, count: 1
    assert_select "a[href=?]", user_path(@user), count: 1
    delete customer_logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", customer_login_path, count: 1
    assert_select "a[href=?]", customer_logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    


  end

end
