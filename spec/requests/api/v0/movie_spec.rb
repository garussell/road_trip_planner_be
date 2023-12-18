require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies', :vcr do
    context 'happy path' do
      it 'returns a list of movies' do
        search = MovieFacade.get_movies

        expect(search).to be_an(Array)
        expect(search.first).to be_a(Movie)

        expect(search.first.title).to be_a(String)
        expect(search.first.genres).to be_an(Array)
        expect(search.first.overview).to be_a(String)
        expect(search.first.release_date).to be_a(String)
        expect(search.first.vote_average).to be_a(Float)
        expect(search.first.vote_count).to be_an(Integer)
        expect(search.first.poster_path).to be_a(String)

      end

      it 'returns a list of movies with a search query' do
        search = MovieService.discover_movies
        
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)

        expect(search[:results].first).to be_a(Hash)
        expect(search[:results].first[:title]).to be_a(String)

        expect(search[:results].first[:genre_ids]).to be_an(Array)
        expect(search[:results].first[:genre_ids].first).to be_an(Integer)
        
        expect(search[:results].first[:overview]).to be_a(String)
        expect(search[:results].first[:release_date]).to be_a(String)

        expect(search[:results].first[:vote_average]).to be_a(Float)
        expect(search[:results].first[:vote_count]).to be_an(Integer)

        expect(search[:results].first[:poster_path]).to be_a(String)
      end

      it 'gets a list of genres' do
        genres = MovieService.genre_hash
        expect(genres).to be_a(Hash)

        expect(genres[:genres]).to be_an(Array)
        expect(genres[:genres].first).to be_a(Hash)
        expect(genres[:genres].first[:id]).to be_an(Integer)
        expect(genres[:genres].first[:name]).to be_a(String)
      end

      it 'GET /movies' do
        get '/api/v0/movies'

        expect(response).to be_successful

        movies = JSON.parse(response.body, symbolize_names: true)

        expect(movies).to be_a(Hash)
        expect(movies[:data]).to be_an(Array)
        expect(movies[:data].first).to be_a(Hash)
        expect(movies[:data].first[:type]).to be_a(String)
        expect(movies[:data].first[:attributes]).to be_a(Hash)
        expect(movies[:data].first[:attributes][:title]).to be_a(String)
        expect(movies[:data].first[:attributes][:genres]).to be_an(Array)
        expect(movies[:data].first[:attributes][:overview]).to be_a(String)
        expect(movies[:data].first[:attributes][:release_date]).to be_a(String)
        expect(movies[:data].first[:attributes][:vote_average]).to be_a(Float)
        expect(movies[:data].first[:attributes][:vote_count]).to be_an(Integer)
        expect(movies[:data].first[:attributes][:poster_path]).to be_a(String)
      end
    end
  end
end