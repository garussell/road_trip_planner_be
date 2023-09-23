class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = check_current_weather(data[:current])
    @daily_weather = check_daily_weather(data[:forecast][:forecastday])
    @hourly_weather = check_hourly_weather(data[:forecast][:forecastday][0][:hour])
  end

  def check_current_weather(data)
    {
      last_updated: data[:last_updated],
      temperature: data[:temp_f],
      feels_like: data[:feelslike_f],
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
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def check_hourly_weather(data)
    data.map do |hour|
      {
        time: format_time(hour[:time]),
        temperature: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end

  private

  def format_time(time)
    Time.parse(time).strftime("%H:%M")
  end
end