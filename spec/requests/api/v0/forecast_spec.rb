require 'rails_helper'

RSpec.describe "Forecast", type: :request do
  describe "GET /api/v0/forecast?", :vcr do
    context "happy path - with valid params" do
      it "returns a forecast for a location" do
        location = "denver,co"
        units = "metric"
        get "/api/v0/forecast?location=#{location}&units=#{units}"

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)
        forecast = response_data[:data]

        expect(forecast).to have_key(:id)
        expect(forecast[:id]).to eq(nil)

        expect(forecast).to have_key(:type)
        expect(forecast[:type]).to eq("forecast")

        expect(forecast).to have_key(:attributes)
        expect(forecast[:attributes]).to be_a(Hash)

        expect(forecast[:attributes]).to have_key(:current_weather) 
        expect(forecast[:attributes][:current_weather]).to be_a(Hash)

        expect(forecast[:attributes][:current_weather]).to have_key(:last_updated)
        expect(forecast[:attributes][:current_weather][:last_updated]).to be_a(String)

        expect(forecast[:attributes][:current_weather]).to have_key(:temperature)
        expect(forecast[:attributes][:current_weather][:temperature]).to be_a(Float)

        expect(forecast[:attributes][:current_weather]).to have_key(:feels_like)  
        expect(forecast[:attributes][:current_weather][:feels_like]).to be_a(Float)

        expect(forecast[:attributes][:current_weather]).to have_key(:humidity)
        expect(forecast[:attributes][:current_weather][:humidity]).to be_a(Integer)

        expect(forecast[:attributes][:current_weather]).to have_key(:uvi)
        expect(forecast[:attributes][:current_weather][:uvi]).to be_a(Float)

        expect(forecast[:attributes][:current_weather]).to have_key(:visibility)
        expect(forecast[:attributes][:current_weather][:visibility]).to be_a(Float)

        expect(forecast[:attributes][:current_weather]).to have_key(:condition)
        expect(forecast[:attributes][:current_weather][:condition]).to be_a(String)

        expect(forecast[:attributes][:current_weather]).to have_key(:icon)
        expect(forecast[:attributes][:current_weather][:icon]).to be_a(String)

        expect(forecast[:attributes]).to have_key(:daily_weather)
        expect(forecast[:attributes][:daily_weather]).to be_a(Array)

        expect(forecast[:attributes][:daily_weather].count).to eq(5)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:date)
        expect(forecast[:attributes][:daily_weather][0][:date]).to be_a(String)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:sunrise)
        expect(forecast[:attributes][:daily_weather][0][:sunrise]).to be_a(String)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:sunset)
        expect(forecast[:attributes][:daily_weather][0][:sunset]).to be_a(String)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:max_temp)
        expect(forecast[:attributes][:daily_weather][0][:max_temp]).to be_a(Float)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:min_temp)
        expect(forecast[:attributes][:daily_weather][0][:min_temp]).to be_a(Float)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:condition)
        expect(forecast[:attributes][:daily_weather][0][:condition]).to be_a(String)

        expect(forecast[:attributes][:daily_weather][0]).to have_key(:icon)
        expect(forecast[:attributes][:daily_weather][0][:icon]).to be_a(String)

        expect(forecast[:attributes]).to have_key(:hourly_weather)
        expect(forecast[:attributes][:hourly_weather]).to be_a(Array)

        expect(forecast[:attributes][:hourly_weather][0]).to have_key(:time)
        expect(forecast[:attributes][:hourly_weather][0][:time]).to be_a(String)

        expect(forecast[:attributes][:hourly_weather][0]).to have_key(:temperature)
        expect(forecast[:attributes][:hourly_weather][0][:temperature]).to be_a(Float)

        expect(forecast[:attributes][:hourly_weather][0]).to have_key(:condition)
        expect(forecast[:attributes][:hourly_weather][0][:condition]).to be_a(String)

        expect(forecast[:attributes][:hourly_weather][0]).to have_key(:icon)
        expect(forecast[:attributes][:hourly_weather][0][:icon]).to be_a(String)
      end

      it "does not return unnecessary data" do
        location = "denver,co"
        get "/api/v0/forecast?location=#{location}"

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)
        forecast = response_data[:data]

        # Current Weather
        expect(forecast[:attributes][:current_weather]).to_not have_key(:last_updated_epoch)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:temp_c)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:temp_f)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:is_day)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_mph)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_kph)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_degree)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:wind_dir)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure_mb)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:pressure_in)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:precip_mm)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:precip_in)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:cloud)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:feels_like_c)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:feels_like_f)

        expect(forecast[:attributes][:current_weather]).to_not have_key(:vis_km)  

        expect(forecast[:attributes][:current_weather]).to_not have_key(:gust_mph)
        expect(forecast[:attributes][:current_weather]).to_not have_key(:gust_kph)
      
        # Daily Weather
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:maxtemp_c)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:maxtemp_f)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:mintemp_c)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:mintemp_f)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:avgtemp_c)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:avgtemp_f)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:maxwind_mph)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:maxwind_kph)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:totalprecip_mm)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:totalprecip_in)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:totalsnow_cm)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:avgvis_km)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:avgvis_miles)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:avghumidity)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:uv)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:daily_will_it_rain)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:daily_chance_of_rain)

        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:daily_will_it_snow)
        expect(forecast[:attributes][:daily_weather][0]).to_not have_key(:daily_chance_of_snow)

        # Hourly Weather
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:time_epoch)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:temp_c)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:is_day)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:wind_mph)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:wind_kph)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:wind_degree)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:wind_dir)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:pressure_in)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:pressure_mb)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:precip_in)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:precip_mm)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:humidity)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:cloud)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:feelslike_c)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:feelslike_f)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:windchill_c)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:windchill_f)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:heatindex_c)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:heatindex_f)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:dewpoint_c)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:dewpoint_f)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:will_it_rain)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:chance_of_rain)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:will_it_snow)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:chance_of_snow)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:vis_km)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:vis_miles)

        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:gust_mph)
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:gust_kph)
        
        expect(forecast[:attributes][:hourly_weather][0]).to_not have_key(:uv)
      end
    end

    context "sad path - with invalid params" do
      it "returns an error message" do
        location = ""
        get "/api/v0/forecast?location=#{location}"

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
      end
    end
  end
end
