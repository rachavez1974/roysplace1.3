require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:razor)
  end

  test "password resets" do
    get new_customer_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post customer_password_resets_path, params: { password_reset: { email: " "}}
    assert_not flash.empty?
    assert_template 'customer/password_resets/new'
    #valid email
    post customer_password_resets_path, params: { password_reset: { email: @user.email}}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty? 
    assert_redirected_to root_url
    # password reset form
    user = assigns(:user)
    # Wrong email
    get edit_customer_password_reset_path(user.reset_token, email: " ")  
    assert_redirected_to root_url
    # Inactive user
    user.toggle!(:activated)
    get edit_customer_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Right email, wrong token
    get edit_customer_password_reset_path("wrong token", email: user.email)
    assert_redirected_to root_url
     # Right email, right token
    get edit_customer_password_reset_path(user.reset_token, email: user.email)
    assert_template 'customer/password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Invalid password & confirmation
    patch customer_password_reset_path(user.reset_token),
                  params: {email: user.email,
                           user: { password: "foobar",
                                   password_confirmation: "notfoobar"
                                 }
                          }

    assert_select 'div.alert', "Please review the problems below:"
    assert_select 'div.invalid-feedback', "Password confirmation doesn't match Password"
    # Empty password
    patch customer_password_reset_path(user.reset_token),
                  params: {email: user.email,
                           user: { password: "",
                                   password_confirmation: ""
                                 }
                          }    
    assert_select 'div.alert', "Please review the problems below:"
    assert_select 'div.invalid-feedback', "Password can't be empty"
    # Valid password & confirmation
    patch customer_password_reset_path(user.reset_token),
                  params: {email: user.email,
                           user: { password: "1",
                                   password_confirmation: "1"
                                 }
                          }    
    assert is_logged_in?
    user.reload
    assert_nil user.reset_digest
    assert_not flash.empty?
    assert_redirected_to customer_user_url(user)

    follow_redirect!  
    assert_select 'div.alert', "#{user.first_name}, your password has been reset."
  end


  test "expired token" do
    get new_customer_password_reset_path
    post customer_password_resets_path,
         params: { password_reset: { email: @user.email } }

    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch customer_password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:              "foobar",
                            password_confirmation: "foobar" } }
    assert_response :redirect
    follow_redirect!
    assert_match "expired", response.body
  end
end
