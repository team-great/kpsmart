require 'test_helper'

class RouteTest < ActiveSupport::TestCase

  def setup
    @route = routes(:one)

    @to_city = cities(:one)
    @from_city = cities(:two)
  end

  def teardown
    @route = nil

    @to_city = nil
    @from_city = nil
  end

  test "updating a route will produce a new verion" do
    assert_difference('@route.versions.count', 1) do
      @route.update(volume_cost: 10)
    end
  end

  test "setting priority_name to air will not error" do
    @route.update(priority_name: "Air")
    assert_empty @route.errors[:priority_name]
  end

  test "setting priority_name to sea will not error" do
    @route.update(priority_name: "Sea")
    assert_empty @route.errors[:priority_name]
  end

  test "setting priority_name to unkown will have an error" do
    @route.update(priority_name: "Mystry")
    assert_not_empty @route.errors[:priority_name]
  end

  test "setting to_name to kown city will not error" do
    @route.update(to_name: @to_city.name)
    assert_empty @route.errors[:to_name]
  end

  test "setting to_name to unkown city will have an error" do
    @route.update(to_name: "Lost City of Alantis")
    assert_not_empty @route.errors[:to_name]
  end

  test "setting from_name to kown city will not error" do
    @route.update(from_name: @from_city.name)
    assert_empty @route.errors[:from_name]
  end

  test "setting from_name to unkown city will have an error" do
    @route.update(from_name: "Lost City of Alantis")
    assert_not_empty @route.errors[:from_name]
  end

end
