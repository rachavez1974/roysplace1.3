require 'test_helper'

class SearcBreakfastitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = lunches(:one)
  end

  test "unsuccessful delete for breakfast item" do
    log_in_as(@admin)
    #item not found
    get admin_deletemenuitem_path
    assert_template 'admin/dashboard/delete_menu_items'
    assert_select "a[href=?]", search_lunch_path, count: 1
    get search_lunch_path
    assert_template 'lunches/search_form'
    assert_select "[action=?]", lunch_profile_path, count: 2
    get lunch_profile_path, params: { id:  "1" }
    assert_not flash.empty?
    assert_template 'lunches/search_form'
  end

  # test "successful delete for breakfast item" do
  #   log_in_as(@admin)
  #   #item not found
  #   get admin_deleteitem_path
  #   assert_template 'admin/dashboard/delete_breakfast_items'
  #   assert_select "a[href=?]", search_breakfast_path, count: 1
  #   get search_breakfast_path
  #   assert_template 'breakfasts/search_form'
  #   assert_select "[action=?]", breakfast_profile_path, count: 2
  #   get breakfast_profile_path, params: { id:  @item.id }
  #   assert flash.empty?
  #   assert_template 'breakfasts/show'
  #   assert_select "a[href=?]", breakfast_path(@item)
  #   assert_difference 'Breakfast.count', -1 do
  #   delete breakfast_path(@item)
  #   end
  #   assert_redirected_to admin_root_url

  # end


end