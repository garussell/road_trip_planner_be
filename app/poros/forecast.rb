# frozen_string_literal: true

class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data, units)
    @id = nil
    @units = units
    @timezone = data[:location][:tz_id]
    @current_weather = check_current_weather(data[:current])
    @daily_weather = check_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = check_hourly_weather(data[:forecast][:forecastday][0][:hour])
  end

  def check_current_weather(data)
    unit_mapping = {
      'imperial' => { temperature: :temp_f, feels_like: :feelslike_f },
      'metric' => { temperature: :temp_c, feels_like: :feelslike_c },
      nil => { temperature: :temp_f, feels_like: :feelslike_f }
    }
  
    unit_data = unit_mapping[@units]
  
    {
      last_updated_epoch: data[:last_updated_epoch],
      last_updated: data[:last_updated],
      temperature: data[unit_data[:temperature]],
      feels_like: data[unit_data[:feels_like]],
      humidity: data[:humidity],
      uvi: data[:uv],
      visibility: data[:vis_miles],
      condition: data[:condition][:text],
      icon: data[:condition][:icon]
    }
  end
  
  def check_daily_weather(data)
    unit_mapping = {
      'imperial' => { max_temp: :maxtemp_f, min_temp: :mintemp_f },
      'metric' => { max_temp: :maxtemp_c, min_temp: :mintemp_c },
      nil => { max_temp: :maxtemp_f, min_temp: :mintemp_f }
    }
  
    data.map do |day|
      unit_data = unit_mapping[@units]
  
      {
        date: day[:date],
        date_epoch: day[:date_epoch],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][unit_data[:max_temp]],
        min_temp: day[:day][unit_data[:min_temp]],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end  

  def check_hourly_weather(data)
    unit_mapping = {
      'imperial' => :temp_f,
      'metric' => :temp_c,
      nil => :temp_f
    }
  
    data.map do |hour|
      unit_key = unit_mapping[@units]
  
      {
        time_epoch: hour[:time_epoch],
        time: format_time(hour[:time]),
        temperature: hour[unit_key],
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
