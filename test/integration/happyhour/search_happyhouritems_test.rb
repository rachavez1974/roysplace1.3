require 'test_helper'

class SearcHappyHouritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = happy_hours(:one)
  end

  test "unsuccessful search for happy hour item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'happy_hours/search_form'
  end

  test "successful search for happy hour item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'happy_hours/show'
  end


end