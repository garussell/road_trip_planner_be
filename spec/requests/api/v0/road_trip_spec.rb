require 'rails_helper'

RSpec.describe "POST /api/v0/road_trip", :vcr do
  before do
    user_params = {
      email: "fake@gmail.com",
      password: "password",
      password_confirmation: "password"
      }

    post "/api/v0/users", params: user_params
    response_data = JSON.parse(response.body, symbolize_names: true)
    @api_key = response_data[:data][:attributes][:api_key]
    
    user_params = {
      email: "fake@gmail.com",
      password: "password",
      password_confirmation: "password"
      }
  
    post "/api/v0/sessions", params: user_params
  end
  
  context "happy path - valid params" do
    it "returns a 200 status code" do

      road_trip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        units: "imperial",
        api_key: @api_key
      }
      post "/api/v0/road_trip", params: road_trip_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)
      road_trip = response_data[:data]

      expect(road_trip).to have_key(:id)
      expect(road_trip[:id]).to be nil

      expect(road_trip).to have_key(:type)
      expect(road_trip[:type]).to eq("road_trip")

      expect(road_trip).to have_key(:attributes)  
      expect(road_trip[:attributes]).to be_a(Hash)

      expect(road_trip[:attributes]).to have_key(:start_city)
      expect(road_trip[:attributes][:start_city]).to be_a(String)
      
      expect(road_trip[:attributes]).to have_key(:end_city)
      expect(road_trip[:attributes][:end_city]).to be_a(String)

      expect(road_trip[:attributes]).to have_key(:travel_time)
      expect(road_trip[:attributes][:travel_time]).to be_a(String)

      expect(road_trip[:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:attributes][:weather_at_eta]).to be_a(Hash)

      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:attributes][:weather_at_eta][:temperature]).to be_a(Float)

      expect(road_trip[:attributes][:weather_at_eta]).to have_key(:condition)
      expect(road_trip[:attributes][:weather_at_eta][:condition]).to be_a(String)

    end
  end

  context "sad path - invalid params" do
    it "returns a 422 status code with invalid parameters" do
      
      road_trip_params = {
        origin: "",
        destination: "Pueblo,CO",
        api_key: @api_key
      }

      post "/api/v0/road_trip", params: road_trip_params

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(response.body).to eq("{\"errors\":[{\"detail\":\"Invalid Parameters\"}]}")
    end

    it "returns a 401 status code with invalid api key" do
      road_trip_params = {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: "invalid_api_key"
      }

      post "/api/v0/road_trip", params: road_trip_params

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(response.body).to eq("{\"errors\":[{\"detail\":\"Unauthorized\"}]}")
    end

    it "returns a 404 status code with impossible route" do
      road_trip_params = {
        origin: "New York, NY",
        destination: "London, UK",
        api_key: @api_key
      }

      post "/api/v0/road_trip", params: road_trip_params

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(response.body).to eq("{\"errors\":[{\"detail\":\"Impossible Route\"}]}")
    end
  end
end