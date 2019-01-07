require 'test_helper'

class SearchLatenightitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = latenights(:one)
  end

  test "unsuccessful search for latenight item" do
    log_in_as(@admin)
    #item not found 
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'latenights/search_form'
  end

  test "successful search for late night item" do
    log_in_as(@admin)
    #item not found
    get admin_searchmenuitem_path
    assert_template 'admin/dashboard/search_menu_items'
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'latenights/show'
  end


end