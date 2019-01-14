require 'test_helper'

class HappyHourMenuDisplayTest < ActionDispatch::IntegrationTest
  
  test "test happy menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", happyhour_menu_path, count: 1
    get happyhour_menu_path
    assert_template 'happy_hours/menu'
    assert_match "Happy Hour Menu", response.body
    
  end  

end
