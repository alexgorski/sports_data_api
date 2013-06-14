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
    describe '.team_rosters' do
      it { expect { subject.team_rosters(2013) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2013) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.team_rosters' do
      it { expect { subject.team_rosters(2013) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:schedule_url) { 'http://api.sportsdatallc.org/mlb-t3/schedule/2013.xml' }
    let(:team_rosters_url) { 'http://api.sportsdatallc.org/mlb-t3/rosters/2013.xml' }

    before(:each) do
      SportsDataApi.mlb_key = 'invalid_key'
      SportsDataApi.access_level = 't'
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key}")
      @team_rosters_xml = RestClient.get("#{team_rosters_url}?api_key=#{api_key}")
    end

    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2013)
      end
    end

    describe '.team_rosters' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.mlb_key } }
        RestClient.should_receive(:get).with(team_rosters_url, params).and_return(@team_rosters_xml)
        subject.team_rosters(2013)
      end
    end
  end
end