  require 'test_helper'

class AdminEditUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:razor)
    @admin = users(:nemo)
  end

  
  
  test "Editing customer via search when is admin logged in with address" do
    get admin_login_path
    log_in_as(@admin)
    assert is_logged_in?
    get admin_search_customer_path
    assert_template 'admin/users/search_form'
    #Look up user by phone number
    get admin_showcustomer_path, params: { phone_number: "#{@user.phone_number}"}
    assert flash.empty?
    assert_template 'admin/users/show'
    assert_select "a[href=?]", admin_path(@user)
    get admin_path(@user)
    name = "James"
    apt_number = "rt"
    patch admin_path(@user), params: { user: { first_name: name,
                                                last_name: "Doe",
                                                phone_number: "3019675309",
                                                :addresses_attributes =>
                                                [{
                                                  user_id: @user.id, 
                                                  street_address: "8134 Fallow dr",
                                                   unit_type: "Floor",
                                                   address_type: "Residence",
                                                   number: apt_number,
                                                   city: "Islamabad",
                                                   state: "State of the union",
                                                   zipcode: "12345"

                                                }]

                                               }
                                       }

    assert_not flash.empty?
    assert_redirected_to admin_user_url(@user)
    @user.reload
    @user.addresses.reload
    assert_equal name, @user.first_name
    assert_equal apt_number, @user.addresses.first.number
  end

  
end
