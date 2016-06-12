require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @city = create(:city)
    @to = build(:route)
    @from = build(:route)
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

  test "can find city by name" do
    city = City.get_id_from_name @city.name

    assert_equal @city.id, city
  end

  test "cannot find non-existing city by name" do
    city = City.get_id_from_name ""

    assert_equal nil, city
  end

end
