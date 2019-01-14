require 'test_helper'

class DeleteBrunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = brunches(:one)
  end

  test "unsuccessful delete for brunch item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_brunch_path, count: 1
    get search_brunch_path
    assert_template 'brunches/search_form'
    assert_select "[action=?]", brunch_profile_path, count: 2
    get brunch_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'brunches/search_form'
  end

  test "successful delete for brunch item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_brunch_path, count: 1
    get search_brunch_path
    assert_template 'brunches/search_form'
    assert_select "[action=?]", brunch_profile_path, count: 2
    get brunch_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'brunches/show'
    assert_select "a[href=?]", brunch_path(@item)
    assert_difference 'Brunch.count', -1 do
    delete brunch_path(@item)
    end
    assert_redirected_to admin_root_url

  end


end