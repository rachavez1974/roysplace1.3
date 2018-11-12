require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "full title helper" do
    assert_equal full_title,  "Roy's Place, a Sandwich Heaven!!"
    assert_equal full_title("Help"), "Help | Roy's Place, a Sandwich Heaven!!"
  end
end