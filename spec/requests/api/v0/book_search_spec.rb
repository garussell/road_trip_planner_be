require 'rails_helper'

RSpec.describe "GET /api/v0/book_search", :vcr do 
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
      location = "denver,co"
      quantity = 5

      get "/api/v0/book_search?location=#{location}&quantity=#{quantity}"

      response_data = JSON.parse(response.body, symbolize_names: true)
      book_search = response_data[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      
    end
  end
end