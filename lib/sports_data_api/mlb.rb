module SportsDataApi
  module Mlb

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'mlb')
    BASE_URL = 'http://api.sportsdatallc.org/mlb-%{access_level}%{version}'

    autoload :Event,   File.join(DIR, 'event')
    autoload :Season, File.join(DIR, 'season')
    autoload :Player, File.join(DIR, 'player')
    autoload :Team, File.join(DIR, 'team')
    autoload :League, File.join(DIR, 'league')

    ##
    # Fetches MLB season schedule for a given year and season.
    def self.schedule(year, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      #season = season.to_s.upcase.to_sym
      #raise SportsDataApi::Mlb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/schedule/#{year}.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      schedule = Nokogiri::XML(response.to_s)
      schedule.remove_namespaces!
      
      return Season.new(schedule.xpath("/calendars"))
    end

    ##
    #
    def self.team_rosters(year, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      #season = season.to_s.upcase.to_sym
      #raise SportsDataApi::Mlb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/rosters/#{year}.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      teams = Nokogiri::XML(response.to_s)
      teams.remove_namespaces!
      #binding.pry
      return League.new(teams.xpath("/rosters"))
    end

    ##
    #

    private
    def self.generic_request(url)
      begin
        return RestClient.get(url, params: { api_key: SportsDataApi.mlb_key })
      rescue RestClient::RequestTimeout => timeout
        raise SportsDataApi::Exception, 'The API did not respond in a reasonable amount of time'
      rescue RestClient::Exception => e
        message = if e.response.headers.key? :x_server_error
                    JSON.parse(e.response.headers[:x_server_error], { symbolize_names: true })[:message]
                  elsif e.response.headers.key? :x_mashery_error_code
                    e.response.headers[:x_mashery_error_code]
                  else
                    "The server did not specify a message"
                  end
        raise SportsDataApi::Exception, message
      end
    end
  end
end
