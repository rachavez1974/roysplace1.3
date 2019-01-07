require 'test_helper'

class LatenightTest < ActiveSupport::TestCase
  def setup
    @item = Latenight.new(name: "Fried frog legs", description: "South African legs", price: 34.78,
                          availability: true, section: "Starters")    
  end  

  test "Latenight item should be valid" do
    assert @item.valid?
  end

  test "latenight item's name should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "latenight item's name should not pass 75 chars" do
    @item.name = "a" * 76
    assert_not @item.valid?
  end

  test "latenight item's description shoul be present" do
    @item.description = ""
    assert_not @item.valid?
  end

  test "latenight item's description should not pass 500 chars" do
    @item.description = "a" * 501
    assert_not @item.valid?
  end

  test "latenight item's price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "latenight item's section should be present" do
    valid_section = %w[Starters Classics Dishes A_La_Carte Confections]
      valid_section.each do |section|
        @item.section = section
        assert @item.valid?
      end
  end
end


