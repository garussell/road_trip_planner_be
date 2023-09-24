class RoadTripFacade
  def self.create_road_trip(params)
    road_trip = RoadTrip.new(params)

    road_trip.calculate_travel_time
    road_trip.calculate_weather_at_eta
    road_trip
  end
end