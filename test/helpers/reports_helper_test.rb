require 'test_helper'

class ReportsHelperTests < ActiveSupport::TestCase
  include ReportsHelper

  # FIXME: current fixtures setup screw up how these reports can be tested

  test "get revenue report" do
    results = revenue_report

    assert_equal [], results
  end

  test "get revenue report with deliveries" do
    create(:mail, :with_route)

    results = revenue_report

    assert_equal 10.0, results.first.price
    assert_equal 20.0, results.first.cost
    assert_equal (-10.0), results.first.profit
  end

end
