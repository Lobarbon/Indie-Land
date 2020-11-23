# frozen_string_literal: true

require_relative 'event_brief_hashes'

module Views
  # View for a single event entity
  class TodayEvents
    def initialize(date, events, index = nil)
      @index = index
      @events = events.map.with_index { |brief_hash, i| BriefHashes.new(brief_hash, i) }
      @date = date
    end

    def date_html_id
      "date[#{@index}]"
    end

    def date
      @date
    end

    def each(&block)
      @events.each(&block)
    end

    def any?
      @events.any?
    end
  end
end
