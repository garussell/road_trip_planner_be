require 'rails_helper'

RSpec.describe RoadTripFacade, :vcr do
  describe "create_road_trip" do

    it "returns a road trip object" do
      road_trip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        units: "imperial",
        api_key: "jgn983hy48thw9begh98h4539h4"
      }

      expect(RoadTripFacade.create_road_trip(road_trip_params)).to be_a(RoadTrip)
    end
  end
end