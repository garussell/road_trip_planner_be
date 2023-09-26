# frozen_string_literal: true

class ForecastSerializer
  include JSONAPI::Serializer
  set_type 'forecast'
  attributes :current_weather, :daily_weather, :hourly_weather

  attribute :current_weather do |object|
    object.instance_variable_get(:@current_weather)
  end

  attribute :daily_weather do |object|
    object.instance_variable_get(:@daily_weather)
  end

  attribute :hourly_weather do |object|
    object.instance_variable_get(:@hourly_weather)
  end
end
