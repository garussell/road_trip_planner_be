# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Background Image', type: :request do
  describe 'GET /api/v0/backgrounds?location=denver,co', :vcr do
    context 'happy path - with valid params' do
      it 'returns a background image for the location' do
        location = 'denver,co'
        get "/api/v0/backgrounds?location=#{location}"

        expect(response).to be_successful

        response_data = JSON.parse(response.body, symbolize_names: true)
        background_image = response_data[:data]

        expect(background_image).to have_key(:id)
        expect(background_image[:id]).to eq(nil)

        expect(background_image).to have_key(:type)
        expect(background_image[:type]).to eq('image')

        expect(background_image).to have_key(:attributes)
        expect(background_image[:attributes]).to be_a(Hash)

        expect(background_image[:attributes]).to have_key(:image)
        expect(background_image[:attributes][:image]).to be_a(Hash)

        expect(background_image[:attributes][:image]).to have_key(:location)
        expect(background_image[:attributes][:image][:location]).to be_a(String)

        expect(background_image[:attributes][:image]).to have_key(:image_url)
        expect(background_image[:attributes][:image][:image_url]).to be_a(String)

        expect(background_image[:attributes][:image]).to have_key(:credit)
        expect(background_image[:attributes][:image][:credit]).to be_a(Hash)

        expect(background_image[:attributes][:image][:credit]).to have_key(:source)
        expect(background_image[:attributes][:image][:credit][:source]).to be_a(String)

        expect(background_image[:attributes][:image][:credit]).to have_key(:author)
        expect(background_image[:attributes][:image][:credit][:author]).to be_a(String)

        expect(background_image[:attributes][:image][:credit]).to have_key(:logo)
        expect(background_image[:attributes][:image][:credit][:logo]).to be_a(String)
      end
    end

    context 'sad path - with invalid params' do
      it 'returns an error message' do
        location = ''
        get "/api/v0/backgrounds?location=#{location}"

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response.body).to eq('{"errors":[{"detail":"Location parameter is required"}]}')
      end
    end
  end
end
