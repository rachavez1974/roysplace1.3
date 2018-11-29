require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)
  end
  
  test "unscuccesful edits" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path, params: { user:{ first_name: "",
                                      email: "",
                                      password: "ff",
                                      password_confirmation: "235"
                                    }
                              } 
  assert_template 'users/edit'  
  end


  test "sucessful edits with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "James"
    email = "jc@gmail.com"
    patch user_path(@user), params: { user:{ first_name: name,
                                             email: email,
                                             password: "",
                                             password_confirmation: ""
                                            }
                                    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.first_name
    assert_equal email, @user.email
  end

end
