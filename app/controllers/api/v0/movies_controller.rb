class Api::V0::MoviesController < ApplicationController
  def index
    render json: MovieSerializer.new(MovieFacade.get_movies)
  end
end