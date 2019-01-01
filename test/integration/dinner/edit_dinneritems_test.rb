require 'test_helper'

class EditDinneritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = dinners(:one)
    
  end

  test "unsuccessful dinner items edits via search" do
    log_in_as(@admin)
    #item not found
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'dinners/search_form'
    #item found then trying to edit
    get dinner_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'dinners/show'
    assert_select "a[href=?]", edit_dinner_path(@item), count: 1 
    
    get edit_dinner_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch dinner_path(@item), params: { dinner: { name: "",
                                                  description: "",
                                                  price: "",
                                                  availability: "",
                                                  section: ""
                                                }
                                          }

    assert flash.empty?
    assert_template 'dinners/edit'
    assert_select 'div.alert', "Please review the problems below:"    
   
  end


test "successful dinner items edits via search" do
    log_in_as(@admin)
    get admin_updatemenuitem_path
    assert_template 'admin/dashboard/update_menu_items'
    #find item first
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'dinners/show'
    assert_select "a[href=?]", edit_dinner_path(@item), count: 1 
    

    get edit_dinner_path(@item)
    name = "Bagel and Huevos"
    price = 3.99
    patch dinner_path(@item), params: { dinner: { name: name,
                                                  description: @item.description,
                                                  price: price,
                                                  availability: @item.availability,
                                                  section: @item.section
                                                }
                                          }

    assert_not flash.empty? 
    assert_redirected_to dinner_url(@item)
    follow_redirect!
    assert_select "div.alert", "#{name} information has been updated!"
    @item.reload
    assert_equal name, @item.name
    assert_equal price, @item.price    
  end
end