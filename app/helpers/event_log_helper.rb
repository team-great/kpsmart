module EventLogHelper
  class Event
    attr_reader :type, :name, :id, :changeset, :created_at, :to, :from
    def initialize(params)
      @name = params[:name]
      @id = params[:id]
      @created_at = params[:created_at]

      @changeset = params[:changeset]

      @to = params[:to]
      @from = params[:from]

      if @to.nil? ^ @from.nil?
        raise 'Given a to or a from, both must be set'
      elsif !@to.nil? && !@from.nil?
        @type = :mail
      else
        @type = params[:type]
      end
    end
  end

  def get_events()
    mails = MailDelivery.all
    events = PaperTrail::Version.all

    events = events.map do |event|
      if event.event == 'create'
        Event.new name: 'Route Creation',
                  id: event.item_id,
                  type: :create,
                  changeset: event.changeset,
                  created_at: event.created_at
      elsif event.changeset
        Event.new name: 'Route Update',
                  type: :update,
                  changeset: event.changeset,
                  created_at: event.created_at
      else
        puts "still got event type #{event} to do"
        Event.new name: 'unkown',
                  created_at: event.created_at
      end
    end

    mails = mails.map do |mail|
      Event.new name: 'Mail Delivery',
                id: mail.id,
                to: mail.to.name,
                from: mail.from.name,
                created_at: mail.created_at
    end

    (events + mails).sort { |a, b| b.created_at <=> a.created_at }
  end
end
