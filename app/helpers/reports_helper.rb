module ReportsHelper

  class Report

    attr_reader :id, :to, :from, :price, :cost
    def initialize(params)
      @id = params[:id]
      @to = params[:to]
      @from = params[:from]
      @price = params[:price]
      @cost = params[:cost]
    end
  end

  def revenue_report

    results = []

    MailDelivery.all.order(created_at: :desc).each do |mail|

      report = Report.new id: mail.id,
        to: mail.to.name,
        from: mail.from.name,
        price: mail.total_price.to_f,
        cost: mail.total_cost.to_f

      results << report
    end

    results
  end
end
