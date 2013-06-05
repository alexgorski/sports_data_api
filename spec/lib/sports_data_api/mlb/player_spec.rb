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
    its(:id) { should eq '10154eef-8834-48e0-97e7-d7436367534c' }
    its(:status) { should eq 'A' }
    its(:jersey) { should eq 23 }
    its(:position) { should eq '1B' }
    its(:mlbam_id) { should eq '408236' }
    its(:first_name) { should eq 'Adrian' }
    its(:last_name { should eq 'Gonzalez' }
    its(:bat_hand { should eq 'L' }
    its(:throw_hand { should eq 'L' }
    its(:weight { should eq '602' }
    its(:height { should eq '225' }
    its(:birthdate { should eq '1982-05-08' }
    its(:birthcity { should eq 'San Diego' }
    its(:birthstate { should eq 'CA' }        
    its(:birthcountry { should eq 'USA' }
    its(:pro_debut { should eq '2004-04-18' }
  end
end