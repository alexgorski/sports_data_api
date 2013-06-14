require "spec_helper"

describe SportsDataApi do
  context "user supplied values" do
    let(:key) { "testing_key123" }
    let(:level) { "b" }
    before(:each) do
      SportsDataApi.nfl_key = key
      SportsDataApi.mlb_key = key
      SportsDataApi.access_level = level
    end
    its(:key) { should eq key }
    its(:access_level) { should eq level }
  end
end
