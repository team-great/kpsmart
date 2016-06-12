require 'test_helper'

class MailDeliveryTest < ActiveSupport::TestCase

  def setup
    @delivery = mail_deliveries(:one)

    @to_city = cities(:one)
    @from_city = cities(:two)

    @route = routes(:one)
  end

  def teardown
    @delivery = nil
    @to_city = nil
    @from_city = nil
  end

  def has_route
    @delivery.routes << @route
    @delivery.save
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
    @delivery.update(to_name: @to_city.name)
    assert_empty @delivery.errors[:to_name]
  end

  test "setting to_name to unkown city will have an error" do
    @delivery.update(to_name: "Lost City of Alantis")
    assert_not_empty @delivery.errors[:to_name]
  end

  test "setting from_name to kown city will not error" do
    @delivery.update(from_name: @from_city.name)
    assert_empty @delivery.errors[:from_name]
  end

  test "setting from_name to unkown city will have an error" do
    @delivery.update(from_name: "Lost City of Alantis")
    assert_not_empty @delivery.errors[:from_name]
  end

  test "mail delivery has a total cost" do
    has_route
    assert_equal 19.98, @delivery.total_cost.to_f
  end

  test "mail delivery has a total price" do
    has_route
    assert_equal 19.98, @delivery.total_price.to_f
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
