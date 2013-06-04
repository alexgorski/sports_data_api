require 'spec_helper'

describe SportsDataApi::Mlb::Season, vcr: {
    cassette_name: 'sports_data_api_mlb_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Mlb::Season }
  describe '.season?' do
    context :PRE do
      it { SportsDataApi::Mlb::Season.valid?(:PRE).should be_true }
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
  context 'results from schedule fetch' do
      let(:season) do
        SportsDataApi.access_level = 't'
        SportsDataApi.mlb_key = api_key
        SportsDataApi::Mlb.schedule(2013)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Mlb::Season) }
      its(:season_year) { should eq 2013 }
      its(:season_id) { should eq '58dd9a81-4a38-4a66-8cd7-32ae4d567ba8' }
      its(:events) { should have_at_least(1000).events }
  end
end