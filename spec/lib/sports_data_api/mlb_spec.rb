require 'spec_helper'

describe SportsDataApi::Mlb, vcr: {
    cassette_name: 'sports_data_api_mlb',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.mlb_key = 'invalid_key'
      SportsDataApi.access_level = 't'
    end
    describe '.schedule' do
      it { expect { subject.schedule(2013) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.game_stats' do
      it { expect { subject.game_stats('0078d447-0b4e-4eb2-a2ac-e1188ea576cb') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.team_rosters' do
      it { expect { subject.team_rosters(2013) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.season_stats' do
      it { expect { subject.season_stats(2013) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2013) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.game_stats' do
      it { expect { subject.game_stats('0078d447-0b4e-4eb2-a2ac-e1188ea576cb') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.team_rosters' do
      it { expect { subject.team_rosters(2013) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.season_stats' do
      it { expect { subject.season_stats(2013) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:schedule_url) { 'http://api.sportsdatallc.org/mlb-t3/schedule/2013.xml' }
    let(:game_stats_url) { 'http://api.sportsdatallc.org/mlb-t3/statistics/0078d447-0b4e-4eb2-a2ac-e1188ea576cb.xml' }
    let(:team_rosters_url) { 'http://api.sportsdatallc.org/mlb-t3/rosters/2013.xml' }
    let(:season_stats_url) { 'http://api.sportsdatallc.org/mlb-t3/seasontd/players/2013.xml' }

    before(:each) do
      SportsDataApi.mlb_key = 'invalid_key'
      SportsDataApi.access_level = 't'
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key}")
      @game_stats_xml = RestClient.get("#{game_stats_url}?api_key=#{api_key}")
      @team_rosters_xml = RestClient.get("#{team_rosters_url}?api_key=#{api_key}")
      @season_stats_xml = RestClient.get("#{season_stats_url}?api_key=#{api_key}")
    end

    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2013)
      end
    end

    describe '.game_stats' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(game_stats_url, params).and_return(@game_stats_xml)
        subject.game_stats('0078d447-0b4e-4eb2-a2ac-e1188ea576cb') #4th event_id of season
      end
    end

    describe '.team_rosters' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(team_rosters_url, params).and_return(@team_rosters_xml)
        subject.team_rosters(2013)
      end
    end

    describe '.season_stats' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(season_stats_url, params).and_return(@season_stats_xml)
        subject.season_stats(2013)
      end
    end
  end
end