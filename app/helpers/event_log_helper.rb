module EventLogHelper
  class Event
    attr_reader :type, :name, :id, :whodunnit, :changeset, :created_at, :to, :from
    def initialize(params)
      @name = params[:name]
      @id = params[:id]
      @created_at = params[:created_at]

      @changeset = params[:changeset]

      @to = params[:to]
      @from = params[:from]

      whodunnit_id = params[:whodunnit]
      if whodunnit_id
        dunnit = User.find_by(id: whodunnit_id)
        @whodunnit = dunnit.email # FIXME: should not use emails but names, but user has no names
      end

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
                  created_at: event.created_at,
                  whodunnit: event.whodunnit
      elsif event.changeset
        Event.new name: 'Route Update',
                  type: :update,
                  changeset: event.changeset,
                  created_at: event.created_at,
                  whodunnit: event.whodunnit

      else
        puts "still got event type #{event} to do"
        Event.new name: 'unkown',
                  created_at: event.created_at,
                  whodunnit: event.whodunnit
      end
    end

    mails = mails.map do |mail|
      Event.new name: 'Mail Delivery',
                id: mail.id,
                to: mail.to.name,
                from: mail.from.name,
                created_at: mail.created_at
                # FIXME: Add responsibility to making a mail delivery object
    end

    (events + mails).sort_by(&:created_at).reverse!
  end
end
