require 'test_helper'

class AddBreakfastitemsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nemo)
    @another_user = users(:razor)  
  end

  test "attempting to add a breakfast item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_additem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end




  test "unsuccessful adding of breakfast items" do
    log_in_as(@user)
    get admin_additem_path
    assert_template 'admin/dashboard/add_new_breakfast_items'
    assert_select "a[href=?]", new_breakfast_path, count: 1
    get new_breakfast_path
    assert_template 'breakfasts/new'
    assert_no_difference 'Breakfast.count' do
    post breakfasts_path, params: { breakfast: { name: " ",
                                                description: "",
                                                price: " ",
                                                section: nil,
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'breakfasts/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of breakfast items" do
    log_in_as(@user)
    get admin_additem_path
    assert_template 'admin/dashboard/add_new_breakfast_items'
    assert_select "a[href=?]", new_breakfast_path, count: 1
    get new_breakfast_path
    assert_template 'breakfasts/new'
    assert_difference 'Breakfast.count', 1 do
    post breakfasts_path, params: { breakfast: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21.99,
                                                section: "A_La_Carte",
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'breakfasts/show'
  end


end
