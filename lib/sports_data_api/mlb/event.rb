module SportsDataApi
  module Mlb
    class Event
      attr_reader :id, :season_type, :status, :visitor, :home, :venue, :broadcast_network, :scheduled_start

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml["id"]
          @season_type = xml["season_type"].to_sym
          @status = xml["status"]
          @visitor = xml.xpath("visitor").first["id"]
          @home = xml["home"]
          @venue = xml["venue"]
          @broadcast_network = xml.xpath("broadcast").first["network"] 
          @scheduled_start = xml.xpath("scheduled_start").text
        end
      end
    end
  end
end