module SportsDataApi
  module Mlb
    class Team
      attr_reader :season_id, :season_year, :id, :abbr, :name, :market, :league, :division, :venue, :players

      def initialize(xml)
        @players = []
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @abbr = xml['abbr']
          @name = xml['name']
          @market = xml['market']
          @league = xml['league']
          @division = xml['division']
          @venue = xml['venue']
          @players = xml.xpath("players").xpath("profile").map do |player_xml|      
            Player.new(player_xml)
          end
        end
      end
    end
  end
end