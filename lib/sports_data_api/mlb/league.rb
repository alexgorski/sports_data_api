module SportsDataApi
  module Mlb
    class League
      attr_reader :season_id, :season_year, :teams, :sport

      def initialize(xml)
        @teams = []
        if xml.is_a? Nokogiri::XML::NodeSet
          @sport = "Mlb"
          @season_id = xml.first["season_id"]
          @season_year = xml.first["season_year"].to_i
          @teams = xml.xpath("team").map do |team_xml|
            Team.new(team_xml)
          end
        end
      end
    end
  end
end