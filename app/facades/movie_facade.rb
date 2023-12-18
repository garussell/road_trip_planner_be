class MovieFacade
  def self.get_movies
    movies = MovieService.discover_movies
    movies[:results].map do |movie|
      Movie.new(movie)
    end
  end
end