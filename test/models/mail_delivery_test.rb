require 'test_helper'

class MailDeliveryTest < ActiveSupport::TestCase

  def setup
    @delivery = mail_deliveries(:one)

    @to_city = cities(:one)
    @from_city = cities(:two)
  end

  def teardown
    @delivery = nil
    @to_city = nil
    @from_city = nil
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

end
