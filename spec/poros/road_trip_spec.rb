# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoadTrip, type: :poros do
  describe 'initialize', :vcr do
    it 'creates a road trip object' do
      road_trip_params = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: 'jgn983hy48thw9begh98h4539h4'
      }

      road_trip = RoadTrip.new(road_trip_params)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to eq('Denver,CO')
      expect(road_trip.end_city).to eq('Pueblo,CO')
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
    end
  end
end
