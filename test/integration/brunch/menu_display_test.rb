require 'test_helper'

class BrunchMenuDisplayTest < ActionDispatch::IntegrationTest
  

  test "test brunch menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", brunch_menu_path, count: 1
    get brunch_menu_path
    assert_template 'brunches/menu'
    assert_match "Brunch Menu", response.body
    assert_match "STARTERS", response.body
    assert_match "Classics", response.body
    assert_match "Dishes", response.body
    assert_match "A La Carte", response.body
    assert_match "Confections", response.body
  end  

end
