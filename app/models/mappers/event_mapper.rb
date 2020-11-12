# frozen_string_literal: true

module IndieLand
  # Data Mapper
  class MusicEventsMapper
    def initialize(gateway_class = MusicApi)
      @gateway_class = gateway_class
      @gateway = @gateway_class.new
    end

    def find_events
      build_entity
    end

    private

    def build_entity
      @gateway.data.map do |event|
        EventMapper.new(event).build_entity
      end
    end

    # Extracts entity specific elements from data structure
    class EventMapper
      def initialize(event)
        @event = event
      end

      def build_entity
        IndieLand::Entity::Event.new(
          event_id: nil,
          event_name: event_name,
          event_website: event_website,
          description: description,
          sale_website: sale_website,
          source_name: source_name,
          sessions: sessions
        )
      end

      private

      def event_name
        @event['title']
      end

      def event_website
        @event['sourceWebPromote']
      end

      def description
        @event['descriptionFilterHtml']
      end

      def sale_website
        @event['webSales']
      end

      def source_name
        @event['sourceWebName']
      end

      def sessions
        @event['showInfo'].map do |session|
          SessionMapper.new(session).build_entity
        end
      end
    end

    # SessionMapper will map sessions of an event
    class SessionMapper
      def initialize(session)
        @session = session
      end

      def build_entity
        IndieLand::Entity::Session.new(
          session_id: nil,
          event_id: nil,
          start_time: start_time,
          end_time: end_time,
          address: address,
          place: place,
          ticket_price: ticket_price
        )
      end

      def start_time
        @session['time']
      end

      def end_time
        @session['endTime']
      end

      def address
        @session['location']
      end

      def place
        @session['locationName']
      end

      def ticket_price
        @session['price']
      end
    end
  end
end
