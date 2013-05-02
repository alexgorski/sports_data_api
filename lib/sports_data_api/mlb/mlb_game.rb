module SportsDataApi
  module Mlb
    class Game
      attr_reader :id, :season_type, :status, :visitor, :visitor_hitting, :home, :home_hitting

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
          
          @home = xml.xpath("home").first["id"]
          @home_hitting = xml.xpath("home").xpath("hitting").xpath("players").xpath("player").map do |xml_player|
            Hitting.new(xml_player, "player")
          end
          
          @home_hitting.unshift(Hitting.new(xml.xpath("home").xpath("hitting").xpath("team").first,"home"))
          #@visitor_hitting = Hitting.new(xml,"visitor")
          #@home = Home.new(xml.xpath("home").first["id"])
          #@home_team_hitting = hitting(xml,"home")
      # Refactor to a 'hitting' method
        end
      end
      

      
    end
  end
end