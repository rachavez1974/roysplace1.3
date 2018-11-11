require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Roy's Place, a Sandwich Heaven!!"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get menus" do
    get static_pages_menus_url
    assert_response :success
    assert_select "title", "Menus | #{@base_title}"
  end

  test "should get offers" do
    get static_pages_offers_url
    assert_response :success
    assert_select "title", "Offers | #{@base_title}"
  end

  test "should get bagged" do
    get static_pages_bagged_url
    assert_response :success 
    assert_select "title", "Bagged | #{@base_title}"
  end

end
