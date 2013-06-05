module SportsDataApi
  module Mlb
    class Pitching
      attr_reader :season_id, :season_year, :events, :pitching

      def initialize(xml, entity)
      
        if xml.is_a? Nokogiri::XML::Element
          
        temp = xml
        temp2 = temp.xpath("onbase").first
        temp3 = temp.xpath("runs").first
        temp4 = temp.xpath("outcome").first
        temp5 = temp.xpath("outs").first
        temp6 = temp.xpath("steal").first
        
        temp.xpath("games").first != nil ? 
        temp7 = temp.xpath("games").first : 
        temp7 = {:play => nil,
              :start => nil,
              :finish => nil,
              :complete => nil,
              :win => nil,
              :loss => nil,
              :save => nil,
              :qstart => nil,
              :shutout => nil}
        
        @pitching =  Hash.new
        @pitching = {entity.to_sym => {
          :pcount => temp["pcounting"],
          :error => temp["error"],
          :ip_1 => temp["ip_1"],
          :ip_2 => temp["ip_2"],
          :bf => temp["bf"],
          :gofo => temp["gofo"],
          :lob => temp["lob"],
          :era => temp["era"],
          :k9 => temp["k9"],
          :whip => temp["whip"],
          :id => temp["id"],
          :onbase => {
            :h => temp2["h"],
            :s => temp2["s"],
            :d => temp2["d"],
            :t => temp2["t"],
            :hr => temp2["hr"],
            :bb => temp2["bb"],
            :ibb => temp2["ibb"],
            :hbp => temp2["hbp"],
          },
          :runs => {
            :unearned => temp3["unearned"],
            :earned => temp3["earned"],
            :total => temp3["total"]
          },
          :outcome => {},
          :outs => {
            :klook => temp5["klook"],
            :kswing => temp5["kswing"],
            :ktotal => temp5["ktotal"],
            :po => temp5["po"],
            :fo => temp5["fo"],
            :fidp => temp5["fidp"],
            :go => temp5["go"],
            :gidp => temp5["gidp"],
            :lo => temp5["lo"],
            :lidp => temp5["lidp"],
            :sacfly => temp5["sacfly"],
            :sachit => temp5["sachit"]
          },
          :steal => {
            :caught => temp6["caught"],
            :stolen => temp6["stolen"]
          },
          :games => {
            :play => temp7["play"],
            :start => temp7["start"],
            :finish => temp7["finish"],
            :complete => temp7["complete"],
            :win => temp7["win"],
            :loss => temp7["loss"],
            :save => temp7["save"],
            :qstart => temp7["qstart"],
            :shutout => temp7["shutout"]
            }
          }
        }
      end
    end



      def self.valid?(season)

      end
     
    end
  end
end