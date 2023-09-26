# frozen_string_literal: true

class ForecastService
  def self.get_forecast(lat, lng)
    get_url("?q=#{lat},#{lng}&days=5")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/forecast.json') do |faraday|
      faraday.headers['key'] = Rails.application.credentials.open_weather[:key]
    end
  end
end
