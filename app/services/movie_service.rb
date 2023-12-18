class MovieService
  def self.discover_movies
    get_url('/3/discover/movie?language=en-US&page=1&sort_by=popularity.desc&append_to_response=credits')
  end

  def self.genre_hash
    get_url('/3/genre/movie/list?language=en')
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.headers['Authorization'] = "Bearer #{Rails.application.credentials.movie_db[:key]}"
    end
  end
end