require 'test_helper'

class RoutesHelperTests < ActiveSupport::TestCase
  include RoutesHelper

  def setup
    @wellington = cities(:wellington)
    @auckland = cities(:auckland)
    @city_one = cities(:one)
  end

  def teardown
    @wellington = nil
    @auckland = nil
    @city_one = nil
  end

  test "can route to no where" do
    result = get_route "", ""

    assert_not result[:valid]
    assert_equal 0, result[:distance]
  end

  test "can route to wlg to akl" do
    result = get_route @wellington.name, @auckland.name
    assert result[:valid]
  end

  test "cannot route to wlg to one" do
    result = get_route @wellington.name, @city_one.name
    assert_not result[:valid]
  end

end
