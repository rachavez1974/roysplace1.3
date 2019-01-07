require 'test_helper'

class AddLatenightitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)  
  end

  test "attempting to add a latenight item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_addmenuitem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end

  test "unsuccessful adding of latenight item" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_latenight_path, count: 1
    get new_latenight_path
    assert_template 'latenights/new'
    assert_no_difference 'Latenight.count' do
    post latenights_path, params: { latenight: { name: " ",
                                                description: "",
                                                price: " ",
                                                section: nil,
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'latenights/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of latenight item" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_latenight_path, count: 1
    get new_latenight_path
    assert_template 'latenights/new'
    assert_difference 'Latenight.count', 1 do
    post latenights_path, params: { latenight: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21.99,
                                                section: "Confections",
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'latenights/show'
  end


end
