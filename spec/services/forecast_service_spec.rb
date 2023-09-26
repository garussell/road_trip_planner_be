# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastService, :vcr do
  describe 'get_forecast' do
    it 'returns the forecast for a location' do
      lat = 39.738453
      lng = -104.984853
      service = ForecastService.get_forecast(lat, lng)

      expect(service).to be_a(Hash)

      # Current Weather
      expect(service).to have_key(:current)
      expect(service[:current]).to be_a(Hash)

      expect(service[:current]).to have_key(:last_updated)
      expect(service[:current][:last_updated]).to be_a(String)

      expect(service[:current]).to have_key(:temp_f)
      expect(service[:current][:temp_f]).to be_a(Float)

      expect(service[:current]).to have_key(:feelslike_f)
      expect(service[:current][:feelslike_f]).to be_a(Float)

      expect(service[:current]).to have_key(:humidity)
      expect(service[:current][:humidity]).to be_a(Integer)

      expect(service[:current]).to have_key(:uv)
      expect(service[:current][:uv]).to be_a(Float)

      expect(service[:current]).to have_key(:vis_miles)
      expect(service[:current][:vis_miles]).to be_a(Float)

      expect(service[:current]).to have_key(:condition)
      expect(service[:current][:condition]).to be_a(Hash)

      expect(service[:current][:condition]).to have_key(:text)
      expect(service[:current][:condition][:text]).to be_a(String)

      expect(service[:current][:condition]).to have_key(:icon)
      expect(service[:current][:condition][:icon]).to be_a(String)

      # Daily Weather
      expect(service).to have_key(:forecast)
      expect(service[:forecast]).to be_a(Hash)

      expect(service[:forecast]).to have_key(:forecastday)
      expect(service[:forecast][:forecastday]).to be_a(Array)

      expect(service[:forecast][:forecastday].count).to eq(5)
      expect(service[:forecast][:forecastday][0]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0]).to have_key(:date)
      expect(service[:forecast][:forecastday][0][:date]).to be_a(String)

      expect(service[:forecast][:forecastday][0]).to have_key(:astro)
      expect(service[:forecast][:forecastday][0][:astro]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0][:astro]).to have_key(:sunrise)
      expect(service[:forecast][:forecastday][0][:astro][:sunrise]).to be_a(String)

      expect(service[:forecast][:forecastday][0][:astro]).to have_key(:sunset)
      expect(service[:forecast][:forecastday][0][:astro][:sunset]).to be_a(String)

      expect(service[:forecast][:forecastday][0]).to have_key(:day)
      expect(service[:forecast][:forecastday][0][:day]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0][:day]).to have_key(:maxtemp_f)
      expect(service[:forecast][:forecastday][0][:day][:maxtemp_f]).to be_a(Float)

      expect(service[:forecast][:forecastday][0][:day]).to have_key(:mintemp_f)
      expect(service[:forecast][:forecastday][0][:day][:mintemp_f]).to be_a(Float)

      expect(service[:forecast][:forecastday][0][:day]).to have_key(:condition)
      expect(service[:forecast][:forecastday][0][:day][:condition]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0][:day][:condition]).to have_key(:text)
      expect(service[:forecast][:forecastday][0][:day][:condition][:text]).to be_a(String)

      # Hourly Weather
      expect(service[:forecast][:forecastday][0]).to have_key(:hour)
      expect(service[:forecast][:forecastday][0][:hour]).to be_a(Array)

      expect(service[:forecast][:forecastday][0][:hour].count).to eq(24)

      expect(service[:forecast][:forecastday][0][:hour][0]).to have_key(:time)
      expect(service[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)

      expect(service[:forecast][:forecastday][0][:hour][0]).to have_key(:temp_f)
      expect(service[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)

      expect(service[:forecast][:forecastday][0][:hour][0]).to have_key(:condition)
      expect(service[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)

      expect(service[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:text)
      expect(service[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)

      expect(service[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:icon)
      expect(service[:forecast][:forecastday][0][:hour][0][:condition][:icon]).to be_a(String)
    end
  end
end
