require 'test_helper'

class BrunchTest < ActiveSupport::TestCase
  def setup
    @item = Brunch.new(name: "Eggs Benedicts", description: "Holland's finest", price: 15,
                       availability: true, section: "Dishes")
  end

  test "brunch itme should be valid" do
    assert @item.valid?
  end

  test "brunch item's name should be present" do
    @item.name = ""
    assert_not @item.valid?
  end

  test "brunch item's name lenght should be not greater than 75" do
    @item.name = "a"*76
    assert_not @item.valid?
  end

  test "brunch item's description should be present" do
    @item.description = ""
    assert_not @item.valid?
  end

  test "brunch item's description should not be greater than 500" do
    @item.description = "a"*501
    assert_not @item.valid?
  end

  test "brunch item's price should be present" do
    @item.price = nil
    assert_not @item.valid?
  end

  test "brunch item's section should be present" do
    valid_section = %w[Starters Classics Dishes A_La_Carte Confections]
      valid_section.each do |section|
        @item.section = section
        assert @item.valid?
      end
  end


end
