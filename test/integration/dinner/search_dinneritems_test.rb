require 'test_helper'

class SearcDinneritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = dinners(:one)
  end

  test "unsuccessful search for diiner item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'dinners/search_form'
  end

  test "successful search for dinner item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_dinner_path, count: 1
    get search_dinner_path
    assert_template 'dinners/search_form'
    assert_select "[action=?]", dinner_profile_path, count: 2
    get dinner_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'dinners/show'
  end


end