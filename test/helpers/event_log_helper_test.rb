require 'test_helper'

class EventLogHelperTests < ActiveSupport::TestCase
  include EventLogHelper
  fixtures :routes, :mail_deliveries

  def create_route
    @route = routes(:one)
  end

  def create_delivery
    @delivery = mail_deliveries(:one)
  end

  def teardown
    @route = nil unless @route.nil?
    @delivery = nil unless @delivery.nil?
  end
  
  # FIXME: Tests disabled while trying to figure out best way to handle papertrail and fixtures
  # test "has route creation event" do
  #   with_versioning do 
  #     create_route

  #     events = get_events
  #     puts events

  #     assert_equal :create, events.last.type
  #   end
  # end
  
  # test "has mail creation event" do
  #   with_versioning do 
  #     create_delivery

  #     events = get_events
  #     puts events

  #     assert_equal :mail, events.first.type
  #   end
  # end
end

