require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)
  end
  
  test "unscuccesful edits" do
    log_in_as(@user)
    get edit_customer_user_path(@user)
    assert_template 'customer/users/edit'
    patch customer_user_path, params: { user:{ first_name: "",
                                      email: "",
                                      password: "ff",
                                      password_confirmation: "235"
                                    }
                              } 
  assert flash.empty?
  assert_select 'div.alert', "Please review the problems below:"    
  assert_template 'customer/users/edit'  
  end


  test "sucessful edits with friendly forwarding and address" do
    get edit_customer_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_customer_user_url(@user)
    name = "John"
    email = "jd@gmail.com"
    apt_number = "2r"
    patch customer_user_path(@user), params: { user: {  first_name: name,
                                          last_name: "Doe",
                                          email: email,
                                          phone_number: "3018675309",
                                          password: "1",
                                          password_confirmation: "1",
                                          terms: true, :addresses_attributes => [{ street_address: "333",
                                                                  number: 'rt',
                                                                  city: "Vienna",
                                                                  state: "Maryland",
                                                                  zipcode: "22222",
                                                                  address_type: "Business",
                                                                  unit_type: "None"
                                                                  }]  
                                       }
                               }
                                  
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@user)
    @user.reload
    assert_equal name, @user.first_name
    assert_equal email, @user.email
    assert_equal apt_number, @user.addresses.first.number
  end

end
