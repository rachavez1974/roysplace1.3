require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)  
  end

  test "attempting login with wrong credentials" do
    get customer_login_path
    assert_template 'sessions/new'
    post customer_login_path, params: { session: { email: " ", password: " " } }


    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?

  end

  test "attempting login with right credentials and follow by logout" do
    get customer_login_path
    assert_select "a[href=?]", customer_login_path, count: 1
    assert_template 'sessions/new'

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
    # Simulate a user clicking logout in a second window.
    delete customer_logout_path
    follow_redirect!
    assert_select "a[href=?]", customer_login_path, count: 1
    assert_select "a[href=?]", customer_logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end


  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

end
