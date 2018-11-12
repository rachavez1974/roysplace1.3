require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", full_title("Home")
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", full_title("About")
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", full_title("Contact")
  end

  test "should get menus" do
    get menus_path
    assert_response :success
    assert_select "title", full_title("Menus")
  end

  test "should get offers" do
    get offers_path
    assert_response :success
    assert_select "title", full_title("Offers")
  end

  test "should get bagged" do
    get bagged_path
    assert_response :success 
    assert_select "title", full_title("Bagged")
  end

end
