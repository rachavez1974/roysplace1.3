require 'test_helper'

class EditBrunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = brunches(:one)
    
  end

  test "unsuccessful brunch items edits via search" do
    log_in_as(@admin)
    #item not found
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    assert_select "a[href=?]", search_brunch_path, count: 1
    get search_brunch_path
    assert_template 'brunches/search_form'
    assert_select "[action=?]", brunch_profile_path, count: 2
    get brunch_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'brunches/search_form'
    #item found then trying to edit
    get brunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'brunches/show'
    assert_select "a[href=?]", edit_brunch_path(@item), count: 1 
    
    get edit_brunch_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch brunch_path(@item), params: { brunch: { name: "",
                                                        description: "",
                                                        price: "",
                                                        availability: "",
                                                        section: ""
                                                      }
                                          }

    assert flash.empty?
    assert_template 'brunches/edit'
    assert_select 'div.alert', "Please review the problems below:"    
   
  end


test "successful brunch items edits via search" do
    log_in_as(@admin)
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    #find item first
    assert_select "a[href=?]", search_brunch_path, count: 1
    get search_brunch_path
    assert_template 'brunches/search_form'
    assert_select "[action=?]", brunch_profile_path, count: 2
    get brunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'brunches/show'
    assert_select "a[href=?]", edit_brunch_path(@item), count: 1 
    

    get edit_brunch_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch brunch_path(@item), params: { brunch: { name: name,
                                                        description: @item.description,
                                                        price: price,
                                                        availability: @item.availability,
                                                        section: @item.section
                                                      }
                                          }

    assert_not flash.empty? 
    assert_redirected_to brunch_url(@item)
    follow_redirect!
    assert_select "div.alert", "#{name} information has been updated!"
    @item.reload
    assert_equal name, @item.name
    assert_equal price, @item.price    
  end
end