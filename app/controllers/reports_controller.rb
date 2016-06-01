class ReportsController < ApplicationController
  include ReportsHelper

  #Both these methods could easily be a single method which would make the data more accesible without
  #displaying too much at any time
  # Requires route finding logic
  def index

    #TODO
    #for each mail_delivery, calculate all values associated with it and display it the the user
    @mail = {}
    @total_cost = 0.0

    MailDelivery.all.order(created_at: :desc).each do |mail|

      cost = mail.total_cost

      @mail["mail_item_#{mail.id}"] = mail.as_json.merge(cost: cost)

      @total_cost = @total_cost + cost
    end

  end

  def revenue

    @mail = revenue_report

  end

  def critical_routes

  end

end
