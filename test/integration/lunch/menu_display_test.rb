require 'test_helper'

class LunchMenuDisplayTest < ActionDispatch::IntegrationTest
  
  test "test lunch menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", lunch_menu_path, count: 1
    get lunch_menu_path
    assert_template 'lunches/menu'
    assert_match "Lunch Menu", response.body
    assert_match "STARTERS", response.body
    assert_match "Classics", response.body
    assert_match "Dishes", response.body
    assert_match "A La Carte", response.body
    assert_match "Confections", response.body
  end  

end
