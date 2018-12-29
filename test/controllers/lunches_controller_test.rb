require 'test_helper'

class LunchesControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get lunches_menu_url
    assert_response :success
  end

  test "should get new" do
    get lunches_new_url
    assert_response :success
  end

  test "should get edit" do
    get lunches_edit_url
    assert_response :success
  end

end
