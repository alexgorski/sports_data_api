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
    its(:id) { should eq 'ef64da7f-cfaf-4300-87b0-9313386b977c' }
    its(:abbr) { should eq 'LA' }
    its(:name) { should eq 'Dodgers' }
    its(:market) { should eq 'Los Angeles' }
    its(:league) { should eq 'NL' }
    its(:division) { should eq 'W' }
    its(:venue) { should eq '66a19c3d-24fe-477d-bee7-c6ef1b98352f' }
    its(:players) { should have_at_least(20).players } 
  end
end