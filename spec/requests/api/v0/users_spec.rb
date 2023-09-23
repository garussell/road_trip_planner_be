require 'rails_helper'

RSpec.describe "Register Users" do
  describe "POST /api/v0/users" do
    context "happy path - user is created" do
      it "returns a 201 status code" do
        user_params = {
          email: "fake@gmail.com",
          password: "password",
          password_confirmation: "password"
          }

        post "/api/v0/users", params: user_params
      
        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        response_data = JSON.parse(response.body, symbolize_names: true)
        user = response_data[:data]

        expect(user).to have_key(:id)
        expect(user[:id]).to be_a(String)

        expect(user).to have_key(:type)
        expect(user[:type]).to eq("users")

        expect(user).to have_key(:attributes)
        expect(user[:attributes]).to be_a(Hash)

        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_a(String)

        expect(user[:attributes]).to have_key(:api_key)
        expect(user[:attributes][:api_key]).to be_a(String)

        expect(user[:attributes]).to_not have_key(:password)
        expect(user[:attributes]).to_not have_key(:password_confirmation)
      end
    end

    context "sad path - user is not created" do
      it "returns a 422 status code" do
        user_params = {
          email: "fake@gmail.com",
          password: "password",
          password_confirmation: "wrongpassword"
          }

        post "/api/v0/users", params: user_params
        expect(response).to_not be_successful

        expect(response.status).to eq(422)
        expect(response.body).to eq("{\"errors\":[{\"detail\":\"Invalid Parameters\"}]}")
      end

      it "returns a 422 status code if user already exists" do
        user_params = {
          email: "veryfake@gmail.com",
          password: "password",
          password_confirmation: "password"
          }

          post "/api/v0/users", params: user_params
          expect(response).to be_successful

          post "/api/v0/users", params: user_params
          expect(response).to_not be_successful
          
          expect(response.status).to eq(422)
          expect(response.body).to eq("{\"errors\":[{\"detail\":\"Email already exists\"}]}")
      end
    end
  end
end