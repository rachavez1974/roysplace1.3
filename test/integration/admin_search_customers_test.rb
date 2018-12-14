require 'test_helper'

class AdminSearchCustomersTest < ActionDispatch::IntegrationTest
  def setup
      @user = users(:razor)
      @admin = users(:nemo)
  end

  test "attempting to search for a user without admin logged in" do
    get admin_dashboard_home_path
    assert_template 'admin/dashboard/home'
    get admin_search_customer_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end

  test "unsucessful searches with logged in admin"  do
    log_in_as(@admin)
    assert is_logged_in?
    get admin_search_customer_path
    #unsuccesful Look up user by phone number
    get admin_profile_path, params: { phone_number: "2024567890"}
    assert_not flash.empty?
    assert_template 'admin/users/search_form'
    assert_select 'div.alert', "Customer not found, please try again!"
    #Unsucessful Look up user by id
    get admin_profile_path, params: { id: "2024567890"}
    assert_not flash.empty?
    assert_template 'admin/users/search_form'
    assert_select 'div.alert', "Customer not found, please try again!"
    #Unsucessful Look up user by email
    get admin_profile_path, params: { emails: "2024567890@juno.com"}
    assert_not flash.empty?
    assert_template 'admin/users/search_form'
    assert_select 'div.alert', "Customer not found, please try again!"

  end


  test "sucessful searches with logged in admin" do
    get admin_dashboard_home_path
    assert_template 'admin/dashboard/home'
    get admin_login_path
    assert_template 'admin/sessions/new'
    post admin_login_path, params: {session:{ email: "mr.james.bond@gmail.com",
                                              password: "password" }
                                    }
    assert is_logged_in?
    assert_redirected_to admin_dashboard_home_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', "Welcome back #{@admin.first_name}"
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    assert_match "Search by Category of your Choice", response.body
    assert_select "input[type=text][name='phone_number']"
    assert_select "input[type=text][name='id']"
    assert_select "input[type=text][name='email']"
    #Look up user by phone number
    get admin_profile_path, params: { phone_number: "#{@user.phone_number}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    #Look up user by id
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    assert_match "Search by Category of your Choice", response.body
    assert_select "input[type=text][name='phone_number']"
    assert_select "input[type=text][name='id']"
    assert_select "input[type=text][name='email']"
    get admin_profile_path, params: { id: "#{@user.id}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    #Look up user by email
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    assert_match "Search by Category of your Choice", response.body
    assert_select "input[type=text][name='phone_number']"
    assert_select "input[type=text][name='id']"
    assert_select "input[type=text][name='email']"
    get admin_profile_path, params: { email: "#{@user.email}"}
    assert flash.empty?
    assert_template 'admin/users/show'
  end

  test "sucessful searches with friendly forwarding" do
    get admin_dashboard_home_path
    assert_template 'admin/dashboard/home'
    get admin_search_customer_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
    log_in_as(@admin)
    assert is_logged_in?
    assert_redirected_to admin_search_customer_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', "Welcome back #{@admin.first_name}"
    #Look up user by phone number
    get admin_profile_path, params: { phone_number: "#{@user.phone_number}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    delete admin_logout_path
    assert_not is_logged_in?
    assert_redirected_to admin_login_url

    get admin_search_customer_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
    log_in_as(@admin)
    assert is_logged_in?
    assert_redirected_to admin_search_customer_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', "Welcome back #{@admin.first_name}"
    #Look up user by id
    get admin_profile_path, params: { id: "#{@user.id}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    delete admin_logout_path
    assert_not is_logged_in?
    assert_redirected_to admin_login_url

    get admin_search_customer_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
    log_in_as(@admin)
    assert is_logged_in?
    assert_redirected_to admin_search_customer_url
    follow_redirect!
    assert_not flash.empty?
    assert_select 'div.alert', "Welcome back #{@admin.first_name}"
    #Look up user by email
    get admin_profile_path, params: { email: "#{@user.email}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    delete admin_logout_path
    assert_not is_logged_in?
    assert_redirected_to admin_login_url  
  end
end
