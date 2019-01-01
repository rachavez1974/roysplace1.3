require 'test_helper'

class AddDinneritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)  
  end

  test "attempting to add a dinner item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_addmenuitem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end

  test "unsuccessful adding of dinner item" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_dinner_path, count: 1
    get new_dinner_path
    assert_template 'dinners/new'
    assert_no_difference 'Dinner.count' do
    post dinners_path, params: { dinner: { name: " ",
                                                description: "",
                                                price: " ",
                                                section: nil,
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'dinners/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of dinner item" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_dinner_path, count: 1
    get new_dinner_path
    assert_template 'dinners/new'
    assert_difference 'Dinner.count', 1 do
    post dinners_path, params: { dinner: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21.99,
                                                section: "Confections",
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'dinners/show'
  end


end
