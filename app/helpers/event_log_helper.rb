module EventLogHelper
  class Event
    attr_reader :type, :name, :id, :changeset, :created_at, :to, :from, :object
    def initialize(params)
      @name = params[:name]
      @id = params[:id]
      @created_at = params[:created_at]

      @changeset = params[:changeset]

      @to = params[:to]
      @from = params[:from]
      @object = params[:object]

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
    id = 0
    events = events.map do |event|
      id += 1
      if event.event == 'create'
        Event.new name: 'Route Creation',
                  id: id += 1,
                  type: :create,
                  changeset: event.changeset,
                  created_at: event.created_at,
                  object: event
      elsif event.changeset
        Event.new name: 'Route Update',
                  id: id += 1,
                  type: :update,
                  changeset: event.changeset,
                  created_at: event.created_at,
                  object: event

      else
        puts "still got event type #{event} to do"
        Event.new name: 'unkown',
                  created_at: event.created_at
      end
    end

    mails = mails.map do |mail|
      Event.new name: 'Mail Delivery',
                id: id += 1,
                to: mail.to.name,
                from: mail.from.name,
                created_at: mail.created_at,
                object: mail

    end

    (events + mails).sort { |a, b| b.created_at <=> a.created_at }
  end
end
