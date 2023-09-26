# frozen_string_literal: true

class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data, units)
    @id = nil
    @units = units
    @current_weather = check_current_weather(data[:current])
    @daily_weather = check_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = check_hourly_weather(data[:forecast][:forecastday][0][:hour])
  end

  def check_current_weather(data)
    {
      last_updated: data[:last_updated],
      temperature: if @units == 'imperial' || @units.nil?
                     data[:temp_f]
                   elsif @units == 'metric'
                     data[:temp_c]
                   end,
      feels_like: if @units == 'imperial' || @units.nil?
                    data[:feelslike_f]
                  elsif @units == 'metric'
                    data[:feelslike_c]
                  end,
      humidity: data[:humidity],
      uvi: data[:uv],
      visibility: data[:vis_miles],
      condition: data[:condition][:text],
      icon: data[:condition][:icon]
    }
  end

  def check_daily_weather(data)
    data.map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: if @units == 'imperial' || @units.nil?
                    day[:day][:maxtemp_f]
                  elsif @units == 'metric'
                    day[:day][:maxtemp_c]
                  end,
        min_temp: if @units == 'imperial' || @units.nil?
                    day[:day][:mintemp_f]
                  elsif @units == 'metric'
                    day[:day][:mintemp_c]
                  end,
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def check_hourly_weather(data)
    data.map do |hour|
      {
        time: format_time(hour[:time]),
        temperature: if @units == 'imperial' || @units.nil?
                       hour[:temp_f]
                     elsif @units == 'metric'
                       hour[:temp_c]
                     end,
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end

  private

  def format_time(time)
    Time.parse(time).strftime('%H:%M')
  end
end
