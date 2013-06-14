require 'spec_helper'

describe SportsDataApi::Mlb::League, vcr: {
    cassette_name: 'sports_data_api_mlb_league',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Mlb::League }
  context 'results from team_rosters fetch' do
      let(:league) do
        SportsDataApi.access_level = 't'
        SportsDataApi.mlb_key = api_key
        SportsDataApi::Mlb.team_rosters(2013)
      end
      subject { league }
      it { should be_an_instance_of(SportsDataApi::Mlb::League) }
      its(:sport) { should eq "Mlb" }
      its(:season_year) { should eq 2013 }
      its(:season_id) { should eq '58dd9a81-4a38-4a66-8cd7-32ae4d567ba8' }
      its(:teams) { should have_at_least(30).teams }
  end
end