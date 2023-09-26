# frozen_string_literal: true

class RoadTripSerializer
  include JSONAPI::Serializer
  set_type 'road_trip'

  attributes :start_city, :end_city, :travel_time, :weather_at_eta

  attribute :weather_at_eta do |object|
    object.instance_variable_get(:@weather_at_eta)
  end
end
