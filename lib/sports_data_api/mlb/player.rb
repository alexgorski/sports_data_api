module SportsDataApi
  module Mlb
    class Player
      attr_reader :status, :jersey, :position, :id, :mlbam_id, :first_name, :last_name, :bat_hand, :throw_hand, :weight, :height, :birthday, :birthcity, :birthstate, :birthcountry, :pro_debut 

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @status = xml["status"]
          @jersey = xml["jersey"].to_i
          @position = xml["position"]
          @id = xml['id']
          @mlbam_id = xml['mlbam_id'].to_i
          @first_name = xml.xpath('first').text
          @last_name = xml.xpath('last').text
          @bat_hand = xml.xpath('bat_hand').text
          @throw_hand = xml.xpath('throw_hand').text
          @weight = xml.xpath('weight').text
          @height = xml.xpath('height').text
          @birthdate = xml.xpath('birthdate').text
          @birthcity = xml.xpath('birthcity').text
          @birthstate = xml.xpath('birthstate').text
          @birthcountry = xml.xpath('birthcountry').text
          @pro_debut =  xml.xpath('pro_debut').text    
        end
      end
    end
  end
end