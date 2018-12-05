require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "attempting signing up with wrong information" do
    get customer_signup_path
    assert_no_difference 'User.count' do
    post customer_signup_path, params: { user: {  first_name: " ",
                                        last_name: "",
                                        email: " ",
                                        phone_number: "",
                                        password: " ",
                                        password_confirmation: "",
                                        terms: ""
                                    }
                              }
    end

    assert_template 'users/new'
    assert_select 'div.alert', "Please review the problems below:"
    assert_select 'div.invalid-feedback', "First name can't be blank"
    assert_select 'div.invalid-feedback', "Last name can't be blank"
    assert_select 'div.invalid-feedback', "Email can't be blank and Email is invalid"
    assert_select 'div.invalid-feedback', "Phone number can't be blank and Phone number is invalid"
    assert_select 'div.invalid-feedback', "Password can't be blank"
    assert_select 'div.invalid-feedback', "Terms can't be blank and Terms can't be blank"

  end

  test "attempting signing up with right information and with account activation" do
    get customer_signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post customer_signup_path, params: { user: {  first_name: "John",
                                          last_name: "Doe",
                                          email: "jd@gmail.com",
                                          phone_number: "3018675309",
                                          password: "1",
                                          password_confirmation: "1",
                                          terms: true
                                       }
                               }
    end

    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not flash.empty?
    follow_redirect!
    assert_select 'div.alert', "Welcome to Roy's Place, please check your email to activate your account!"
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_customer_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_customer_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_customer_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!  
    assert_template 'users/show'
    assert is_logged_in?
        
  end

end
