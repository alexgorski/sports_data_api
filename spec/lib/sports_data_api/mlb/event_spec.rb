require 'spec_helper'

describe SportsDataApi::Mlb::Event, vcr: {
    cassette_name: 'sports_data_api_mlb_event',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
    let(:season) do
      SportsDataApi.access_level = 't'
      SportsDataApi.mlb_key = api_key
      SportsDataApi::Mlb.schedule(2013)
    end
    subject { season.events.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Event) }
    its(:id) { should eq '000c465f-7c8c-46bb-8ea7-c26b2bc7c296' }
    its(:season_type) { should eq :REG }
    its(:status) { should eq "scheduled" }
    its(:visitor) { should eq "575c19b7-4052-41c2-9f0a-1c5813d02f99" }
    its(:home) { should eq "833a51a9-0d84-410f-bd77-da08c3e5e26e" }
    its(:venue) { should eq "6fca95c9-7f2c-4acb-a9f3-02ef96340d2a" }
    its(:broadcast_network) { should eq "" }
    its(:scheduled_start) { should eq "2013-09-08T18:10:00Z"}
  end
end