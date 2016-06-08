require 'test_helper'

class ReportsHelperTests < ActiveSupport::TestCase
  include ReportsHelper

  # FIXME: current fixtures setup screw up how these reports can be tested

  test "get revenue report" do
    results = revenue_report

    assert_not_nil results
  end

end
