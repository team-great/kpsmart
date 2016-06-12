require 'test_helper'

class EventLogHelperTests < ActiveSupport::TestCase
  include EventLogHelper

  def create_route
    @route = create(:route)
  end

  def create_delivery
    @delivery = create(:mail, :with_route)
  end
  
  test "has route creation event" do
    with_versioning do 
      create_route

      events = get_events

      assert_equal :create, events.last.type
    end
  end
  
  test "has mail creation event" do
    with_versioning do 
      create_delivery

      events = get_events

      assert_equal :mail, events.first.type
    end
  end
end

