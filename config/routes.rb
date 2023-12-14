# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip, only: [:create]
      resources :book_search, only: [:index]
      resources :backgrounds, only: [:index]

    end
    
    namespace :v1 do
      # Combined endpoint
      get '/data', to: 'data#index'
    end
  end
end
