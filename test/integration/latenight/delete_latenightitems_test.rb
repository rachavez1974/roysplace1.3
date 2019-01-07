require 'test_helper'

class DeleteLatenightitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = latenights(:one)
  end

  test "unsuccessful delete for latenight item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'latenights/search_form'
  end

  test "successful delete for late night item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_latenight_path, count: 1
    get search_latenight_path
    assert_template 'latenights/search_form'
    assert_select "[action=?]", latenight_profile_path, count: 2
    get latenight_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'latenights/show'
    assert_select "a[href=?]", latenight_path(@item)
    assert_difference 'Latenight.count', -1 do
    delete latenight_path(@item)
    end
    assert_redirected_to admin_root_url
  end


end