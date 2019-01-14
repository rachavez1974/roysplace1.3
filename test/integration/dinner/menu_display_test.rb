require 'test_helper'

class DinnerMenuDisplayTest < ActionDispatch::IntegrationTest
  

  test "test dinner menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", dinner_menu_path, count: 1
    get dinner_menu_path
    assert_template 'dinners/menu'
    assert_match "Dinner Menu", response.body
    assert_match "STARTERS", response.body
    assert_match "Classics", response.body
    assert_match "Dishes", response.body
    assert_match "A La Carte", response.body
    assert_match "Confections", response.body
  end  

end
