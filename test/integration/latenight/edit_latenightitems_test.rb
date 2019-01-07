require 'test_helper'

class EditLatenightitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = latenights(:one)
    
  end

  test "unsuccessful latenights items edits via search" do
    log_in_as(@admin)
    #item not found
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'latenights/search_form'
    #item found then trying to edit
    get latenight_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'latenights/show'
    assert_select "a[href=?]", edit_latenight_path(@item), count: 1 
    
    get edit_latenight_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch latenight_path(@item), params: { latenight: { name: "",
                                                  description: "",
                                                  price: "",
                                                  availability: "",
                                                  section: ""
                                                }
                                          }

    assert flash.empty?
    assert_template 'latenights/edit'
    assert_select 'div.alert', "Please review the problems below:"    
   
  end


test "successful latenight items edits via search" do
    log_in_as(@admin)
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    #find item first
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'latenights/show'
    assert_select "a[href=?]", edit_latenight_path(@item), count: 1 
    

    get edit_latenight_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch latenight_path(@item), params: { latenight: { name: name,
                                                  description: @item.description,
                                                  price: price,
                                                  availability: @item.availability,
                                                  section: @item.section
                                                }
                                          }

    assert_not flash.empty? 
    assert_redirected_to latenight_url(@item)
    follow_redirect!
    assert_select "div.alert", "#{name} information has been updated!"
    @item.reload
    assert_equal name, @item.name
    assert_equal price, @item.price    
  end
end