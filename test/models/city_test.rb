require 'test_helper'

class CityTest < ActiveSupport::TestCase

  def setup
    @city = cities(:one)
    @to = Route.create(to: @city, provider: "AU")
    @from = Route.create(from: @city, provider: "NZ")
  end

  def teardown
    @to = nil
    @from = nil
    @city = nil
  end

  test "a city has routes to it" do
    assert_equal @city.to, [@to]
  end

  test "a city has routes from it" do
    assert_equal @city.from, [@from]
  end

  test "a city has routes" do
    assert_equal @city.routes, [@to, @from]
  end

end
