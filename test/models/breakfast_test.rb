require 'test_helper'

class BreakfastTest < ActiveSupport::TestCase
  def setup
    @item = Breakfast.new(name: "Chillaquiles", description: "Typical Mexican breakfast", price: 9.99, availability: true, section: "Starters")
  end

  test "breakfast item should be valid" do
    assert @item.valid?
  end

  test "breakfast item's name should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "breakfast item's name should not be longer than 75 chars" do
    @item.name = "a" * 76
    assert_not @item.valid?
  end

  test "breakfast item's description should be present" do
    @item.description = ""
    assert_not @item.valid?
  end

  test "breakfast item's description should not be longer than 500 chars" do
    @item.description = "a" * 501
    assert_not @item.valid?
  end

  test "breakfast item's price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "breakfast item's section should be present" do
    valid_section = %w[Starters Classics Dishes A_La_Carte Confections]
      valid_section.each do |section|
        @item.section = section
        assert @item.valid?
        
      end
  end

end
