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