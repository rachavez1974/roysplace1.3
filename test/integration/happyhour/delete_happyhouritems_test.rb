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
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'happy_hours/search_form'
  end

  test "successful delete for happy hour item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_happyhour_path, count: 1
    get search_happyhour_path
    assert_template 'happy_hours/search_form'
    assert_select "[action=?]", happyhour_profile_path, count: 2
    get happyhour_profile_path, params: { id:  @item.id }
    assert flash.empty?
    assert_template 'happy_hours/show'
    assert_select "a[href=?]", happy_hour_path(@item)
    assert_difference 'HappyHour.count', -1 do
    delete happy_hour_path(@item)
    end
    assert_redirected_to admin_root_url

  end


end