require 'test_helper'

class LatenightMenuDisplayTest < ActionDispatch::IntegrationTest
  

  test "test latenight menu displays correctly" do
    get root_path
    assert_template 'static_pages/home'
    get menus_path
    assert_select "a[href=?]", latenight_menu_path, count: 1
    get latenight_menu_path
    assert_template 'latenights/menu'
    assert_match "Late Night Menu", response.body
    assert_match "STARTERS", response.body
    assert_match "Classics", response.body
    assert_match "Dishes", response.body
    assert_match "A La Carte", response.body
    assert_match "Confections", response.body
  end  

end
