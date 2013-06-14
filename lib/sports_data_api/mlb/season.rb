module SportsDataApi
  module Mlb
    class Season
      attr_reader :season_id, :season_year, :events

      def initialize(xml)
        @events = []
        if xml.is_a? Nokogiri::XML::NodeSet
          @season_id = xml.first["season_id"]
          @season_year = xml.first["season_year"].to_i
          @events = xml.xpath("event").map do |week_xml|
            Event.new(week_xml)
          end
        end
      end
    end
  end
end