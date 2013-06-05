require 'spec_helper'

describe SportsDataApi::Mlb::League, vcr: {
    cassette_name: 'sports_data_api_mlb_league',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Mlb::League }
  describe '.league?' do
    context :PRE do
      it { SportsDataApi::Mlb::League.valid?(:PRE).should be_true }
    end
    context :REG do
      it { subject.valid?(:REG).should be_true }
    end
    context :PST do
      it { subject.valid?(:PST).should be_true }
    end
    context :pre do
      it { subject.valid?(:pre).should be_false }
    end
    context :reg do
      it { subject.valid?(:reg).should be_false }
    end
    context :pst do
      it { subject.valid?(:pst).should be_false }
    end
  end
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
      its(:season_id) { should eq '' }
      its(:teams) { should have(30).teams }
  end
end