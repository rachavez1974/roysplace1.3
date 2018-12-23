require 'test_helper'

class AdminSignupUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:nemo)
    @another_user = users(:razor)  
  end

  test "attempting signing up user without admin logged in" do
    get admin_login_path
    assert_template 'admin/sessions/new'
    get admin_signup_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end

   test "attempting signing up user without admin permissions" do
      
    log_in_as(@another_user)
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert', "Welcome back #{@another_user.first_name}" 
    get admin_signup_path 
    assert_redirected_to root_url
  end

  
  test "attempting signing up with right information, and login, and address, but with no validation" do
    get admin_login_path
    assert_select "a[href=?]", admin_login_path, count: 1
    assert_template 'admin/sessions/new'
      post admin_login_path, params: { session: { email: "mr.james.bond@gmail.com", password: "password" } }

    assert is_logged_in?
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/dashboard/home'
    get admin_signup_path
    assert_template 'admin/users/new'
    name = "John"
    assert_difference 'User.count', 1 do 
      post admin_signup_path, params: { user: { first_name: name,
                                                last_name: "Doe",
                                                phone_number: "3019675309",
                                                :addresses_attributes =>
                                                [{ street_address: "8134 Fallow dr",
                                                zipcode: "12345"

                                                }]

                                               }
                                       }
    end
    
    user = assigns(:user)
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert', "#{user.first_name} was added!"
    assert_template 'admin/users/show'
  end
end
