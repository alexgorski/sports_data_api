require 'spec_helper'

describe SportsDataApi::Mlb::Player, vcr: {
    cassette_name: 'sports_data_api_mlb_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:team_rosters) do
    SportsDataApi.mlb_key = api_key
    SportsDataApi.access_level = 't'
    SportsDataApi::Mlb.team_rosters(2013)
  end
  describe 'player' do
    subject { team_rosters.teams.first.players.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Player) }
    its(:id) { should eq '' }
    its(:status) { should eq '' }
    its(:jersey) { should eq '' }
    its(:position) { should eq '' }
    its(:mlbam_id) { should eq '' }
    its(:first_name) { should eq '' }
    its(:last_name { should eq '' }
    its(:bat_hand { should eq '' }
    its(:throw_hand { should eq '' }
    its(:weight { should eq '' }
    its(:height { should eq '' }
    its(:birthdate { should eq '' }
    its(:birthcity { should eq '' }
    its(:birthstate { should eq '' }        
    its(:birthcountry { should eq '' }
    its(:pro_debut { should eq '' }
  end
end