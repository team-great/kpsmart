require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @city = cities(:one)
    @to = routes(:one)
    @from = routes(:two)

  end

  def teardown
    @to = nil
    @from = nil
    @city = nil
  end

  def routes_via_id
    @to.to = @city
    @from.from = @city

    assert @to.save, @to.errors.first
    assert @from.save, @from.errors.first
  end

  def routes_via_name
    @to.to_name = @city.name
    @from.from_name = @city.name

    assert @to.save, @to.errors.first
    assert @from.save, @from.errors.first
  end

  test "a city has routes to it (via id)" do
    routes_via_id
    assert_equal [@to], @city.to
  end

  test "a city has routes from it (via id)" do
    routes_via_id
    assert_equal [@from], @city.from
  end

  test "a city has routes (via id)" do
    routes_via_id
    assert_equal [@to, @from], @city.routes
  end

  test "a city has routes to it (via name)" do
    routes_via_name
    assert_equal [@to], @city.to
  end

  test "a city has routes from it (via name)" do
    routes_via_name
    assert_equal [@from], @city.from
  end

  test "a city has routes (via name)" do
    routes_via_name
    assert_equal [@to, @from], @city.routes
  end
end
