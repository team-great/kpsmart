require 'test_helper'

class RoutesHelperTests < ActiveSupport::TestCase
  include RoutesHelper

  def setup
    @wellington = create(:city)
    @auckland = create(:city)
    @city_one = create(:city)

    @route = create(:route, from: @wellington, to: @auckland)
  end

  test "can route to no where" do
    result = get_route "", ""

    assert_not result.valid
    assert_equal 0, result.distance
  end

  test "can route to wlg to akl" do
    result = get_route @wellington.name, @auckland.name
    assert result.valid
  end

  test "cannot route to wlg to one" do
    result = get_route @wellington.name, @city_one.name
    assert_not result.valid
  end

end
