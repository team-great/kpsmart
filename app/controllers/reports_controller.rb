class ReportsController < ApplicationController
  include ReportsHelper
  include EventLogHelper

  #Both these methods could easily be a single method which would make the data more accesible without
  #displaying too much at any time
  # Requires route finding logic
  def index
    mail = MailDelivery.all
    
    @total_revenue = mail.inject(0) {|a,m| a + m.total_price }
    @total_cost = mail.inject(0) {|a,m| a + m.total_cost }
    @event_count = get_events.count
  end

  def revenue

    @mail = revenue_report

  end

  def critical_routes

  end

end
