module SportsDataApi
  module Mlb
    class Hitting
      attr_reader :season_id, :season_year, :events, :h

      def initialize(xml, entity)
      
        if xml.is_a? Nokogiri::XML::Element
          
        temp = xml
        temp2 = temp.xpath("onbase").first
        temp3 = temp.xpath("runs").first
        temp4 = temp.xpath("outcome").first
        temp5 = temp.xpath("outs").first
        temp6 = temp.xpath("steal").first
        temp7 = temp.xpath("games").first
        
        @h =  Hash.new(
          entity.to_sym => {
            :ab => temp["ab"],
            :ap => temp["ap"],
            :avg => temp["avg"],
            :lob => temp["lob"],
            :pcount => temp["pcount"],
            :rbi => temp["rbi"],
            :error => temp["error"],
            :abhr => temp["abhr"],
            :bip => temp["bip"],
            :babip => temp["babip"],
            :bbk => temp["bbk"],
            :bbpa => temp["bbpa"],
            :gofo => temp["gofo"],
            :iso => temp["iso"],
            :obp => temp["obp"],
            :ops => temp["ops"],
            :seca => temp["seca"],
            :slg => temp["bslg"],
            :tb => temp["btb"],
            :xbh => temp["xbh"],
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
            :games => temp7["play"]
          }
        )
        return h
      end
    end



      def self.valid?(season)

      end
     
    end
  end
end