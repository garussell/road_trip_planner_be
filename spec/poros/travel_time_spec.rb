require 'rails_helper'

RSpec.describe TravelTime, type: :poros do
  describe "initialize", :vcr do
    it "creates a travel time object" do 
      raw_data = {:route=>
        {:sessionId=>"AIcA5wcAAAUBAAAHAAAABQAAAJ8AAAB42mOYz8DAyMTAwMCekVqUapWcK8ppLM3AwMCgYLJ9B4fVyTDTTUVOMSB6c5FTDAMWANO47nwfWOMzkd2CTKb3Z5v-32waDaMZcAD52UobrzEwMDR4sHAE8QowKDAwOIDEG0BUgwIDFwcbAFQoIJ1ST5VB:car",
        :realTime=>6127,
        :distance=>113.6227,
        :time=>5917,
        :formattedTime=>"01:38:37",
        :hasHighway=>true,
        :hasTollRoad=>false,
        :hasBridge=>true,
        :hasSeasonalClosure=>false,
        :hasTunnel=>false,
        :hasFerry=>false,
        :hasUnpaved=>false,
        :hasTimedRestriction=>false,
        :hasCountryCross=>false,
        :legs=>
          [{:index=>0,
            :hasTollRoad=>false,
            :hasHighway=>true,
            :hasBridge=>true,
            :hasUnpaved=>false
        }]}}

      travel_time = TravelTime.new(raw_data)

      expect(travel_time).to be_a(TravelTime)
      expect(travel_time.formatted_time).to eq("01:38:37")
      expect(travel_time.seconds).to eq(5917)
    end
  end
end