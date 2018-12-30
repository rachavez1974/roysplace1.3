require 'test_helper'

class SearcLunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = lunches(:one)
  end

  test "unsuccessful search for lunch item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_lunch_path, count: 1
    get search_lunch_path
    assert_template 'lunches/search_form'
    assert_select "[action=?]", lunch_profile_path, count: 2
    get lunch_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'lunches/search_form'
  end

  test "successful search for lunch item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_lunch_path, count: 1
    get search_lunch_path
    assert_template 'lunches/search_form'
    assert_select "[action=?]", lunch_profile_path, count: 2
    get lunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'lunches/show'
  end


end