require 'test_helper'

class HappyHourTest < ActiveSupport::TestCase
  def setup
    @item = HappyHour.new(name: "Wings", description: "Fried wings with choice of sauce", price: 7.89,
                          availability: true)    
  end

  test "Happy hour item shoud be valid" do
    assert @item.valid?
  end

  test "Happy hour item's name should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "Happy hour item's length should not surpass 75 chars" do
    @item.name = "a" * 76
    assert_not @item.valid?
  end

  test "Happy hour item's description shoulb be present" do
    @item.description = ""
    assert_not @item.valid?
  end

  test "Happy hour item's description should not surpass 500 chars" do
    @item.description = "a" * 501
    assert_not @item.valid?
  end

  test "Happy hour item's price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end
end
