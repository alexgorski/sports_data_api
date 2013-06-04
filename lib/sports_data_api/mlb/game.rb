module SportsDataApi
  module Mlb
    class Game
      attr_reader :id, :season_type, :status, :visitor, :visitor_hitting, :visitor_pitching, :home, :home_hitting, :home_pitching

      def initialize(xml)
        @visitor_hitting = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml["id"]
          @season_type = xml["season_type"]
          @status = xml["status"]
          @visitor = xml.xpath("visitor").first["id"]
          @visitor_hitting = xml.xpath("visitor").xpath("hitting").xpath("players").xpath("player").map do |xml_player|
            Hitting.new(xml_player, "player")
          end
          @visitor_hitting.unshift(Hitting.new(xml.xpath("visitor").xpath("hitting").xpath("team").first,"visitor"))
          
          @visitor_pitching = xml.xpath("visitor").xpath("pitching").xpath("players").xpath("player").map do |xml_player|
            Pitching.new(xml_player, "player")
          end
          @visitor_pitching.unshift(Pitching.new(xml.xpath("visitor").xpath("pitching").xpath("team").first,"visitor"))

          @home = xml.xpath("home").first["id"]
          @home_hitting = xml.xpath("home").xpath("hitting").xpath("players").xpath("player").map do |xml_player|
            Hitting.new(xml_player, "player")
          end
          @home_hitting.unshift(Hitting.new(xml.xpath("home").xpath("hitting").xpath("team").first,"home"))

          @home_pitching = xml.xpath("home").xpath("pitching").xpath("players").xpath("player").map do |xml_player|
            Pitching.new(xml_player, "player")
          end
          @home_pitching.unshift(Pitching.new(xml.xpath("home").xpath("pitching").xpath("team").first,"home"))
         
        end
      end  
    end
  end
end