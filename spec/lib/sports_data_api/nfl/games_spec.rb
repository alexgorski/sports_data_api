require 'spec_helper'

describe SportsDataApi::Nfl::Games, vcr: {
    cassette_name: 'sports_data_api_nfl_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from weekly schedule fetch' do
    let(:games) do
      SportsDataApi.access_level = 't'
      SportsDataApi.key = api_key
      SportsDataApi::Nfl.weekly(2012, :PRE, 1)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Nfl::Games) }
    its(:count) { should eq 16 }
  end
end