require 'test_helper'

class BrunchesControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get brunches_menu_url
    assert_response :success
  end

  test "should get show" do
    get brunches_show_url
    assert_response :success
  end

  test "should get new" do
    get brunches_new_url
    assert_response :success
  end

  test "should get edit" do
    get brunches_edit_url
    assert_response :success
  end

end
