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
  assert_template 'customer/users/edit'  
  end


  test "sucessful edits with friendly forwarding" do
    get edit_customer_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_customer_user_url(@user)
    name = "James"
    email = "jc@gmail.com"
    patch customer_user_path(@user), params: { user:{ first_name: name,
                                             email: email,
                                             password: "",
                                             password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to customer_user_url(@user)
    @user.reload
    assert_equal name, @user.first_name
    assert_equal email, @user.email
  end

end
