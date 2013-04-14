require 'spec_helper'

describe SportsDataApi::Nfl::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nfl_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.access_level = 't'
    SportsDataApi.key = api_key
    SportsDataApi::Nfl.weekly(2011, :PST, 4)
  end
  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.broadcast }
    its(:network) { should eq 'NBC' }
    its(:satellite) { should eq '' }
    its(:internet) { should eq 'NFL Redzone' }
  end
end