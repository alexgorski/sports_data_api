require 'spec_helper'

describe SportsDataApi::Mlb::Game, vcr: {
    cassette_name: 'sports_data_api_mlb_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:game) do
    SportsDataApi.mlb_key = api_key
    SportsDataApi.access_level = 't'
    SportsDataApi::Mlb.game_stats('insert_event_id')
  end
  #rethink pitching and hitting classes => should I use more instance variables 
  #or keep as nested hash?
  context 'results from game_stats fetch' do
    subject { game.home_pitching.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Pitching) }
    its(:id) { should eq '' }
    its(:season_type) { should eq '' }
    its(:home) { should eq '' }
    its(:visitor) { should eq '' }
    its(:status) { should eq '' }
    its(:home_hitting) { should be_an_instance_of(SportsDataApi::Mlb::Hitting) }
    its(:home_pitching) { should be_an_instance_of(SportsDataApi::Mlb::Pitching) }
    its(:visitor_hitting) { should be_an_instance_of(SportsDataApi::Mlb::Hitting) }
    its(:visitor_pitching) { should be_an_instance_of(SportsDataApi::Mlb::Pitching) }
  end
  context 'results from '
end