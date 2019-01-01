require 'test_helper'

class DeleteDinneritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = dinners(:one)
  end

  test "unsuccessful delete for dinner item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'dinners/search_form'
  end

  test "successful delete for dinner item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'dinners/show'
    assert_select "a[href=?]", dinner_path(@item)
    assert_difference 'Dinner.count', -1 do
    delete dinner_path(@item)
    end
    assert_redirected_to admin_root_url
  end


end