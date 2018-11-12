require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "test layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", '/', count: 3
    assert_select "a[href=?]", menus_path, count: 2
    assert_select "a[href=?]", contact_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", bagged_path
    assert_select "a[href=?]", offers_path
  end
end
