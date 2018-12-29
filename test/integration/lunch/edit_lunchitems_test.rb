require 'test_helper'

class EditBreakfastitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = lunches(:one)
    
  end

  test "unsuccessful breakfast items edits via search" do
    log_in_as(@admin)
    #item not found
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    assert_select "a[href=?]", search_lunch_path, count: 1
    get search_lunch_path
    assert_template 'lunches/search_form'
    assert_select "[action=?]", lunch_profile_path, count: 2
    get lunch_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'lunches/search_form'
    #item found then trying to edit
    get lunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'lunches/show'
    assert_select "a[href=?]", edit_lunch_path(@item), count: 1 
    
    get edit_lunch_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch lunch_path(@item), params: { lunch: { name: "",
                                                        description: "",
                                                        price: "",
                                                        availability: "",
                                                        section: ""
                                                      }
                                          }

    assert flash.empty?
    assert_template 'lunches/edit'
    assert_select 'div.alert', "Please review the problems below:"    
   
  end


test "successful breakfast items edits via search" do
    log_in_as(@admin)
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    #find item first
    assert_select "a[href=?]", search_lunch_path, count: 1
    get search_lunch_path
    assert_template 'lunches/search_form'
    assert_select "[action=?]", lunch_profile_path, count: 2
    get lunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'lunches/show'
    assert_select "a[href=?]", edit_lunch_path(@item), count: 1 
    

    get edit_lunch_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch lunch_path(@item), params: { lunch: { name: name,
                                                        description: @item.description,
                                                        price: price,
                                                        availability: @item.availability,
                                                        section: @item.section
                                                      }
                                          }

    assert_not flash.empty? 
    assert_redirected_to lunch_url(@item)
    follow_redirect!
    assert_select "div.alert", "#{name} information has been updated!"
    @item.reload
    assert_equal name, @item.name
    assert_equal price, @item.price    
  end
end