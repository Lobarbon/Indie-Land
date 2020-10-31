# frozen_string_literal: true

module IndieLand
  # Data Mapper
  class Mapper
    def initialize(gateway_class = IndieLand::MusicApi)
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
          event_name: event_name,
          website: website,
          sessions: sessions
        )
      end

      private

      def event_name
        @event['title']
      end

      def website
        @event['sourceWebPromote']
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
          start_time: start_time,
          end_time: end_time,
          address: address,
          place: place
        )
      end

      def start_time
        @session['time']
      end

      def address
        @session['location']
      end

      def place
        @session['locationName']
      end

      def end_time
        @session['endTime']
      end
    end
  end
end