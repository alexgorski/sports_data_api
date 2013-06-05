require 'spec_helper'

describe SportsDataApi::Mlb::Season, vcr: {
    cassette_name: 'sports_data_api_mlb_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.access_level = 't'
    SportsDataApi.mlb_key = api_key
    SportsDataApi::Mlb.schedule(2013)
  end
  describe 'season' do
    subject { season }
    it { should be_an_instance_of(SportsDataApi::Mlb::Season) }
    its(:season_year) { should eq 2013 }
    its(:season_id) { should eq '58dd9a81-4a38-4a66-8cd7-32ae4d567ba8' }
    its(:events) { should have_at_least(1000).events }
  end
end