require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "fetch_or_cache" do
    let(:key) { "forecast-#{location}" }  

    context "when the cache is empty" do
      let(:location) { "denver,co" }

      before do
        allow(Rails.cache).to receive(:read).with(key).and_return(nil)
      end

      it "returns the data from the block" do
        result = controller.fetch_or_cache(key) { "data" }

        expect(result).to eq("data")
      end
    end

    context "when the cache is not empty" do
      let(:location) { "denver,co" }

      before do
        allow(Rails.cache).to receive(:read).with(key).and_return("cached data")
      end

      it "returns the data from the cache" do
        allow(Rails.cache).to receive(:write).with(key, "cached data", expires_in: 1.hour)
        result = controller.fetch_or_cache(key) { "data" }

        expect(result).to eq("cached data")
        expect(Rails.cache).to_not have_received(:write)
      end
    end
  end
end