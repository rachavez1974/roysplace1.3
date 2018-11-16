require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest


  test "attempting signing up with wrong information" do
    get signup_path
    assert_no_difference 'User.count' do
    post users_path, params: { user: {  first_name: " ",
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
    assert_select 'div.invalid-feedback', "Password confirmation can't be blank and Password confirmation is too short (minimum is 1 character)"
    assert_select 'div.invalid-feedback', "Terms can't be blank and Terms can't be blank"

  end

  test "attempting signing up with right information" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: {  first_name: "John",
                                          last_name: "Doe",
                                          email: "jd@gmail.com",
                                          phone_number: "3018675309",
                                          password: "1",
                                          password_confirmation: "1",
                                          terms: true
                                       }
                               }
    end
     follow_redirect!
     assert_template 'users/show'
     assert_not flash.empty?
     assert_select 'div.alert', "Welcome to Roy's Place!"
  end

end
