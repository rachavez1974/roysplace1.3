require 'test_helper'

class DinnerTest < ActiveSupport::TestCase
  def setup
    @item = Dinner.new(name: "Towonba Pasta", description: "Typical Australian dinner", price: 19.99, availability: true, section: "Classics")
  end

  test "dinner item should be valid" do
    assert @item.valid?
  end

  test "dinner item's name should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "dinner item's name should not be longer than 75 chars" do
    @item.name = "a" * 76
    assert_not @item.valid?
  end

  test "dinner item's description should be present" do
    @item.description = ""
    assert_not @item.valid?
  end

  test "dinner item's description should not exceed 500 chars" do
    @item.description = 'a' * 501
    assert_not @item.valid?
  end

  test "dinner item's price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "dinner item's section should be present" do
    valid_section = %w[Starters Classics Dishes A_La_Carte Confections]
      valid_section.each do |section|
        @item.section = section
        assert @item.valid?
      end
  end
end
