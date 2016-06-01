module ReportsHelper

  def revenue_report

    results = []

    MailDelivery.all.order(created_at: :desc).each do |mail|

      results << {
        id: mail.id,
        to: mail.to.name,
        from: mail.from.name,
        price: mail.total_price.to_f,
        cost: mail.total_cost.to_f
      }
    end

    results
  end
end
