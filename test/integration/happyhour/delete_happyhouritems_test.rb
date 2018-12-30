require 'test_helper'

class DeleteHappyHouritemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = breakfasts(:one)
  end

  test "unsuccessful delete for happy hour item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_breakfast_path, count: 1
    get search_breakfast_path
    assert_template 'breakfasts/search_form'
    assert_select "[action=?]", breakfast_profile_path, count: 2
    get breakfast_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'breakfasts/search_form'
  end

  test "successful delete for happy hour item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_breakfast_path, count: 1
    get search_breakfast_path
    assert_template 'breakfasts/search_form'
    assert_select "[action=?]", breakfast_profile_path, count: 2
    get breakfast_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'breakfasts/show'
    assert_select "a[href=?]", breakfast_path(@item)
    assert_difference 'Breakfast.count', -1 do
    delete breakfast_path(@item)
    end
    assert_redirected_to admin_root_url

  end


end