require 'test_helper'

class MailDeliveryTest < ActiveSupport::TestCase

  def setup
    @delivery = build(:mail, :with_route)
  end

  test "setting priority_name to air will not error" do
    @delivery.update(priority_name: "Air")
    assert_empty @delivery.errors[:priority_name]
  end

  test "setting priority_name to sea will not error" do
    @delivery.update(priority_name: "Sea")
    assert_empty @delivery.errors[:priority_name]
  end

  test "setting priority_name to unkown will have an error" do
    @delivery.update(priority_name: "Mystry")
    assert_not_empty @delivery.errors[:priority_name]
  end

  test "setting to_name to kown city will not error" do
    @delivery.update(to_name: @delivery.to.name)
    assert_empty @delivery.errors[:to_name]
  end

  test "setting to_name to unkown city will have an error" do
    @delivery.update(to_name: "Lost City of Alantis")
    assert_not_empty @delivery.errors[:to_name]
  end

  test "setting from_name to kown city will not error" do
    @delivery.update(from_name: @delivery.from.name)
    assert_empty @delivery.errors[:from_name]
  end

  test "setting from_name to unkown city will have an error" do
    @delivery.update(from_name: "Lost City of Alantis")
    assert_not_empty @delivery.errors[:from_name]
  end

  test "mail delivery has a total cost" do
    assert_equal 20.0, @delivery.total_cost.to_f
  end

  test "mail delivery has a total price" do
    assert_equal 10.0, @delivery.total_price.to_f
  end

  test "volume is greater than 0" do
    @delivery.update(volume: 0)
    assert_not_empty @delivery.errors[:volume]
  end

  test "weight is greater than 0" do
    @delivery.update(weight: 0)
    assert_not_empty @delivery.errors[:weight]
  end

  test "volume is present" do
    @delivery.update(volume: nil)
    assert_not_empty @delivery.errors[:volume]
  end

  test "weight is present" do
    @delivery.update(weight: nil)
    assert_not_empty @delivery.errors[:weight]
  end

end
