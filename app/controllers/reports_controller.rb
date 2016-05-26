class ReportsController < ApplicationController


  #Both these methods could easily be a single method which would make the data more accesible without
  #displaying too much at any time
  # Requires route finding logic
  def index

    #TODO
    #for each mail_delivery, calculate all values associated with it and display it the the user
    @mail = {}
    @total_cost = 0.0

    MailDelivery.all.order(created_at: :desc).each do |mail|

      weight_cost = 0.0
      volume_cost = 0.0
      cost = 0.0

      mail.routes.each do |route|

        weight_cost = weight_cost + route.weight_cost
        volume_cost = volume_cost + route.volume_cost

      end

      cost = (weight_cost * mail.weight) + (volume_cost * mail.size)

      @mail["mail_item_#{mail.id}"] = mail.as_json.merge(:cost => cost)

      @total_cost = @total_cost + cost

    end

  end

  def revenue

    #TODO
    #for each mail delivery, sum the value that is being brought in
    @mail = {}

    MailDelivery.all.order(created_at: :desc).each do |mail|

      weight_cost = 0.0
      volume_cost = 0.0
      cost = 0.0

      mail.routes.each do |route|

        weight_cost = weight_cost + route.weight_cost
        volume_cost = volume_cost + route.volume_cost

      end

      cost = (weight_cost * mail.weight) + (volume_cost * mail.volume)

    end

  end

  def critical_routes

  end

end
