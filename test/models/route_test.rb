require 'test_helper'

class RouteTest < ActiveSupport::TestCase

  def setup
    @route = routes(:one)

    @to_city = cities(:wellington)
    @from_city = cities(:auckland)
  end

  def teardown
    @route = nil

    @to_city = nil
    @from_city = nil
  end

  ## Versioning / Route Event tests

  test "updating a route will produce a new verion" do
    assert_difference('@route.versions.count', 1) do
      @route.update(volume_cost: 10)
    end
  end

  ## Validation tests
  
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
    @route.errors.each do |r, t|
      puts r
      puts r
      puts r
      puts r
      puts r
      puts r
      puts r
      puts r
      puts r
      puts t
      puts t
      puts t
      puts t
      puts t
      puts t
    end
    assert_empty @route.errors[:from_name]
  end

  test "setting from_name to unkown city will have an error" do
    @route.update(from_name: "Lost City of Alantis")
    assert_not_empty @route.errors[:from_name]
  end

  test "can update volume cost to above 0" do
    @route.update(volume_cost: 10)
    assert_empty @route.errors[:volume_cost]
  end

  test "cannot update volume cost to below 0" do
    @route.update(volume_cost: -10)
    assert_not_empty @route.errors[:volume_cost]
  end

  test "can update volume cost to 0" do
    @route.update(volume_cost: 0) # FIXME: probably not best to allow cost to be updated to 0
    assert_empty @route.errors[:volume_cost]
  end

  test "can update weight cost to above 0" do
    @route.update(weight_cost: 10)
    assert_empty @route.errors[:weight_cost]
  end

  test "cannot update weight cost to below 0" do
    @route.update(weight_cost: -10)
    assert_not_empty @route.errors[:weight_cost]
  end

  test "can update weight cost to 0" do
    @route.update(weight_cost: 0) # FIXME: probably not best to allow cost to be updated to 0
    assert_empty @route.errors[:weight_cost]
  end

  test "can update weight max to above 0" do
    @route.update(max_weight: 10)
    assert_empty @route.errors[:max_weight]
  end

  test "cannot update weight max to below 0" do
    @route.update(max_weight: -10)
    assert_not_empty @route.errors[:max_weight]
  end

  test "can update weight max to 0" do
    @route.update(max_weight: 0) # FIXME: probably not best to allow max to be updated to 0
    assert_empty @route.errors[:max_weight]
  end

  test "can update volume max to above 0" do
    @route.update(max_volume: 10)
    assert_empty @route.errors[:max_volume]
  end

  test "cannot update volume max to below 0" do
    @route.update(max_volume: -10)
    assert_not_empty @route.errors[:max_volume]
  end

  test "can update volume max to 0" do
    @route.update(max_volume: 0) # FIXME: probably not best to allow max to be updated to 0
    assert_empty @route.errors[:max_volume]
  end

  test "can update duration  to above 0" do
    @route.update(duration: 10)
    assert_empty @route.errors[:duration]
  end

  test "cannot update duration  to below 0" do
    @route.update(duration: -10)
    assert_not_empty @route.errors[:duration]
  end

  test "can update duration  to 0" do
    @route.update(duration: 0) # FIXME: so fast, too fast? 
    assert_empty @route.errors[:duration]
  end

  test "can update frequency  to above 0" do
    @route.update(frequency: 10)
    assert_empty @route.errors[:frequency]
  end

  test "cannot update frequency  to below 0" do
    @route.update(frequency: -10)
    assert_not_empty @route.errors[:frequency]
  end

  test "can update frequency to 0" do
    @route.update(frequency: 0) # FIXME: so fast, too fast? 
    assert_empty @route.errors[:frequency]
  end

end
