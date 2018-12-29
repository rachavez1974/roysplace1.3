require 'test_helper'

class AddLunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nemo)  
  end

  test "attempting to add a lunch item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_addmenuitem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end




  test "unsuccessful adding of lunch item" do
    log_in_as(@user)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_lunch_path, count: 1
    get new_lunch_path
    assert_template 'lunches/new'
    assert_no_difference 'Lunch.count' do
    post lunches_path, params: { lunch: { name: " ",
                                                description: "",
                                                price: " ",
                                                section: nil,
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'lunches/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of lunch item" do
    log_in_as(@user)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_lunch_path, count: 1
    get new_lunch_path
    assert_template 'lunches/new'
    assert_difference 'Lunch.count', 1 do
    post lunches_path, params: { lunch: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21.99,
                                                section: "A_La_Carte",
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'lunches/show'
  end


end
