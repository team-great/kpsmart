require 'test_helper'

class RoutesHelperTests < ActiveSupport::TestCase
  include RoutesHelper

  def setup

  end

  def teardown

  end

  test "can route to no where" do
    result = get_route "", ""

    assert_equal false, result[:valid]
    assert_equal 0, result[:distance]
  end

end
