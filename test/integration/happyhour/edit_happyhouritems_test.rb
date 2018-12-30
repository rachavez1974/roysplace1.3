require 'test_helper'

class EditHappyHouritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = happy_hours(:one)  
  end

  test "unsuccessful happy hour items edits via search" do
    log_in_as(@admin)
    #item not found
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'happy_hours/search_form'
    #item found then trying to edit
    get happyhour_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'happy_hours/show'
    assert_select "a[href=?]", edit_happy_hour_path(@item), count: 1 
    get edit_happy_hour_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch happy_hour_path(@item), params: { happy_hour: { name: "",
                                                        description: "",
                                                        price: "",
                                                        availability: ""
                                                      }
                                          }

    assert flash.empty?
    assert_template 'happy_hours/edit'
    assert_select 'div.alert', "Please review the problems below:"    
   
  end


test "successful happy hour items edits via search" do
    log_in_as(@admin)
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    #find item first
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'happy_hours/show'
    assert_select "a[href=?]", edit_happy_hour_path(@item), count: 1 
    get edit_happy_hour_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch happy_hour_path(@item), params: { happy_hour: { name: name,
                                                        description: @item.description,
                                                        price: price,
                                                        availability: @item.availability
                                                      }
                                          }

    assert_not flash.empty? 
    assert_redirected_to happy_hour_url(@item)
    follow_redirect!
    assert_select "div.alert", "#{name} information has been updated!"
    @item.reload
    assert_equal name, @item.name
    assert_equal price, @item.price    
  end
end