# frozen_string_literal: true

class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(params)
    @id = id
    @units = params[:units]
    @start_city = params[:origin]
    @end_city = params[:destination]
    @travel_time = calculate_travel_time.formatted_time
    @seconds = calculate_travel_time.seconds
    @eta_time = add_time_to_current_time
    @weather_at_eta = calculate_weather_at_eta
  end

  def calculate_travel_time
    MapQuestFacade.new(@start_city).get_time_object(@end_city)
  end

  def calculate_weather_at_eta
    return unless @eta_time

    coordinates = MapQuestFacade.new(@end_city).get_coordinates
    lat = coordinates.lat
    lng = coordinates.lng

    forecast = ForecastFacade.new(lat, lng, @units).forecast

    {
      datetime: (Time.now + @seconds).strftime('%Y-%m-%d %H:%M'),
      temperature: find_temperature(forecast.hourly_weather),
      condition: find_condition(forecast.hourly_weather)
    }
  end

  private

  def add_time_to_current_time
    return unless @seconds

    result = Time.now + @seconds
    result.strftime('%H')
  end

  def find_temperature(forecast)
    forecast.find { |hash| hash[:time][0..1] == @eta_time }&.fetch(:temperature, nil)
  end

  def find_condition(forecast)
    forecast.find { |hash| hash[:time][0..1] == @eta_time }&.fetch(:condition, nil)
  end
end
