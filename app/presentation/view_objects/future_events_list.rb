# frozen_string_literal: true

require_relative 'future_today_events'

module Views
  # View Object Future Dates
  class FutureEvents
    def initialize(future_events)
      @future_events_dates = future_events.future_dates
      @future_events = @future_events_dates.map.with_index do |date, index|
        TodayEvents.new(date, future_events.events_on_this_date(date), index)
      end
    end

    def each(&block)
      @future_events.each(&block)
    end

    def any?
      @future_events.any?
    end
  end
end