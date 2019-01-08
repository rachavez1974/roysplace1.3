require 'test_helper'

class DeleteBrunchitemsTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:nemo)
    @item = brunches(:one)
  end

  test "unsuccessful delete for lunch item" do
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

  # test "successful delete for lunch item" do
  #   log_in_as(@admin)
  #   #item not found
  #   get admin_deletemenuitem_path
  #   assert_template 'admin/dashboard/delete_menu_items'
  #   assert_select "a[href=?]", search_lunch_path, count: 1
  #   get search_lunch_path
  #   assert_template 'lunches/search_form'
  #   assert_select "[action=?]", lunch_profile_path, count: 2
  #   get lunch_profile_path, params: { id:  @item.id }
  #   assert flash.empty?
  #   assert_template 'lunches/show'
  #   assert_select "a[href=?]", lunch_path(@item)
  #   assert_difference 'Lunch.count', -1 do
  #   delete lunch_path(@item)
  #   end
  #   assert_redirected_to admin_root_url

  # end


end