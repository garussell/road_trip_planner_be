require 'rails_helper'

RSpec.describe "POST /api/v0/sessions" do
  before do
    user_params = {
      email: "fake@gmail.com",
      password: "password",
      password_confirmation: "password"
      }

    post "/api/v0/users", params: user_params
  end

  context "happy path - user found and verified" do
    it "returns a 200 status code" do
      user_params = {
        email: "fake@gmail.com",
        password: "password",
        }
      
      post "/api/v0/sessions", params: user_params
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)
      session = response_data[:data]

      expect(session).to have_key(:id)
      expect(session[:id]).to be_a(String)

      expect(session).to have_key(:type)
      expect(session[:type]).to eq("users")

      expect(session).to have_key(:attributes)
      expect(session[:attributes]).to be_a(Hash)

      expect(session[:attributes]).to have_key(:email)
      expect(session[:attributes][:email]).to be_a(String)

      expect(session[:attributes]).to have_key(:api_key)
      expect(session[:attributes][:api_key]).to be_a(String)
    end
  end

  context "sad path - user not found or invalide email or password" do
    it "returns a 422 status code" do
      # User not registered
      user_params = {
        email: "veryfake@gmail.com",
        password: "password",
        }

      post "/api/v0/sessions", params: user_params

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(response.body).to eq("{\"errors\":[{\"detail\":\"Invalid email or password\"}]}")

      # User registered but wrong password
      user_params_2 = {
        email: "superfake@gmail.com",
        password: "password",
        }

      post "/api/v0/users", params: user_params_2

      user_params_3 = {
        email: "superfake@gmail.com",
        password: "wrongpassword"
        }
      
      post "/api/v0/sessions", params: user_params_3
        
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(response.body).to eq("{\"errors\":[{\"detail\":\"Invalid email or password\"}]}")
    end
  end
end