class EventLogController < ApplicationController
  include EventLogHelper

  def index
    @events = get_events
  end
end
