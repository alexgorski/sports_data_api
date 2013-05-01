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

      def self.valid?(season)

      end
      ##
      # Check if the requested season is a valid
      # NFL season type.
      #
      # The only valid types are: :PRE, :REG, :PST
      def self.valid?(season)
        [:PRE, :REG, :PST].include?(season)
      end
    end
  end
end