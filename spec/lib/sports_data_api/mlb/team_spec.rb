require 'spec_helper'

describe SportsDataApi::Mlb::Team, vcr: {
    cassette_name: 'sports_data_api_mlb_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:team_rosters) do
    SportsDataApi.mlb_key = api_key
    SportsDataApi.access_level = 't'
    SportsDataApi::Mlb.team_rosters(2013)
  end
  describe 'team' do
    subject { team_rosters.teams.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Team) }
    its(:id) { should eq '' }
    its(:abbr) { should eq '' }
    its(:name) { should eq '' }
    its(:market) { should eq '' }
    its(:league) { should eq '' }
    its(:division) { should eq '' }
    its(:venue) { should eq '' }
    its(:players) { should have_at_least(9).players } 
  end
end