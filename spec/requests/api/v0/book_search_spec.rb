# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/v0/book_search', :vcr do
  before do
    user_params = {
      email: 'fake@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v0/users', params: user_params
    response_data = JSON.parse(response.body, symbolize_names: true)
    @api_key = response_data[:data][:attributes][:api_key]

    user_params = {
      email: 'fake@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/api/v0/sessions', params: user_params
  end

  context 'happy path - valid params' do
    it 'returns a 200 status code' do
      location = 'denver,co'
      quantity = 5

      get "/api/v0/book_search?location=#{location}&quantity=#{quantity}"

      response_data = JSON.parse(response.body, symbolize_names: true)
      book_search = response_data[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(book_search).to be_a(Hash)

      expect(book_search).to have_key(:id)
      expect(book_search[:id]).to be nil

      expect(book_search).to have_key(:type)
      expect(book_search[:type]).to eq('books')

      expect(book_search).to have_key(:attributes)
      expect(book_search[:attributes]).to be_a(Hash)

      expect(book_search[:attributes]).to have_key(:destination)
      expect(book_search[:attributes][:destination]).to be_a(String)

      expect(book_search[:attributes]).to have_key(:forecast)
      expect(book_search[:attributes][:forecast]).to be_a(Hash)

      expect(book_search[:attributes][:forecast]).to have_key(:summary)
      expect(book_search[:attributes][:forecast][:summary]).to be_a(String)

      expect(book_search[:attributes][:forecast]).to have_key(:temperature)
      expect(book_search[:attributes][:forecast][:temperature]).to be_a(String)

      expect(book_search[:attributes]).to have_key(:books)
      expect(book_search[:attributes][:books]).to be_an(Array)

      expect(book_search[:attributes][:books].count).to eq(5)
      expect(book_search[:attributes][:books].first).to be_a(Hash)

      expect(book_search[:attributes][:books].first).to have_key(:title)
      expect(book_search[:attributes][:books].first[:title]).to be_a(String)

      expect(book_search[:attributes][:books].first).to have_key(:author)
      expect(book_search[:attributes][:books].first[:author].first).to be_a(String)

      expect(book_search[:attributes][:books].first).to have_key(:publish_year)
      expect(book_search[:attributes][:books].first[:publish_year].first).to be_a(Integer)

      expect(book_search[:attributes][:books].first).to have_key(:publisher)
      expect(book_search[:attributes][:books].first[:publisher]).to be_a(String)

      expect(book_search[:attributes][:books].first).to have_key(:preview)
      expect(book_search[:attributes][:books].first[:preview]).to be_a(String)
    end
  end

  context 'sad path - invalid params' do
    it 'returns a 422 status code' do
      # Quantity can be blank
      location = 'denver,co'
      quantity = nil

      get "/api/v0/book_search?location=#{location}&quantity=#{quantity}"
      JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      # Location cannot be blank
      location_b = nil
      quantity_b = 5

      get "/api/v0/book_search?location=#{location_b}&quantity=#{quantity_b}"
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      expect(response_data[:errors]).to eq([{ detail: 'Invalid Location Parameter' }])
    end

    it 'has to be a real location' do
      location = 'asdfasdf'
      quantity = 5

      get "/api/v0/book_search?location=#{location}&quantity=#{quantity}"
      JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
    end
  end
end
