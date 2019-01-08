require 'test_helper'

class AddBrunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nemo)  
  end

  test "attempting to add a brunch item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_addmenuitem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end


  test "unsuccessful adding of brunch item" do
    log_in_as(@user)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_brunch_path, count: 1
    get new_brunch_path
    assert_template 'brunches/new'
    assert_no_difference 'Brunch.count' do
    post brunches_path, params: { brunch: { name: " ",
                                                description: "",
                                                price: " ",
                                                section: nil,
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'brunches/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of brunch item" do
    log_in_as(@user)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_brunch_path, count: 1
    get new_brunch_path
    assert_template 'brunches/new'
    assert_difference 'Brunch.count', 1 do
    post brunches_path, params: { brunch: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21.99,
                                                section: "A_La_Carte",
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'brunches/show'
  end
end
