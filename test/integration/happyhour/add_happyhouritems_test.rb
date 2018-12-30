    require 'test_helper'

class AddHappyHouritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)  
  end

  test "attempting to add an happy hour item without admin logged in" do
    get admin_root_path
    assert_template 'admin/dashboard/home'
    get admin_addmenuitem_path
    assert_not flash.empty?
    follow_redirect!
    assert_template 'admin/sessions/new'
    assert_select 'div.alert', "Please log in."
  end




  test "unsuccessful adding of a happy hour item" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_happy_hour_path, count: 1
    get new_happy_hour_path
    assert_template 'happy_hours/new'
    assert_no_difference 'HappyHour.count' do
    post happy_hours_path, params: { happy_hour: { name: " ",
                                                description: "",
                                                price: " ",
                                                available: ""
                                    }
                              }
    end
    assert flash.empty?
    assert_template 'happy_hours/new'
    assert_select 'div.alert', "Please review the problems below:"    
  end

  test "successful adding of happy hour items" do
    log_in_as(@admin)
    get admin_addmenuitem_path
    assert_template 'admin/dashboard/add_new_menu_items'
    assert_select "a[href=?]", new_happy_hour_path, count: 1
    get new_happy_hour_path
    assert_template 'happy_hours/new'
    assert_difference 'HappyHour.count', 1 do
    post happy_hours_path, params: { happy_hour: { name: "Escargot",
                                                description: "Snail mushrooms",
                                                price: 21,
                                                availability: true
                                    }
                              }
    end
 
    assert_not flash.empty?
    follow_redirect! 
    assert_template 'happy_hours/show'
  end


end
