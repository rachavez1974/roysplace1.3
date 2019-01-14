require 'test_helper'

class BreakfastMenuDisplayTest < ActionDispatch::IntegrationTest
  

  test "test breakfast menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", breakfast_menu_path, count: 1
    get breakfast_menu_path
    assert_template 'breakfasts/menu'
    assert_match "Breakfast Menu", response.body
    assert_match "STARTERS", response.body
    assert_match "Classics", response.body
    assert_match "Dishes", response.body
    assert_match "A La Carte", response.body
    assert_match "Confections", response.body
  end  

end
