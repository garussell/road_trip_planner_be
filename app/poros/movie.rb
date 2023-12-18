class Movie
  attr_reader :id,
              :title, 
              :genres, 
              :overview, 
              :release_date, 
              :vote_average, 
              :vote_count, 
              :poster_path

  def initialize(data)
    @id = nil
    @title = data[:title] unless data[:title].nil?
    @genres = get_genre_names(data[:genre_ids]) unless data[:genre_ids].nil?
    @overview = data[:overview] unless data[:overview].nil?
    @release_date = data[:release_date] unless data[:release_date].nil?
    @vote_average = data[:vote_average] unless data[:vote_average].nil?
    @vote_count = data[:vote_count] unless data[:vote_count].nil?
    @poster_path = data[:poster_path] unless data[:poster_path].nil?
  end

  private

  def get_genre_names(genre_ids)
    genre_names = []
    genre_ids&.each do |genre_id|
      genre = MovieService.genre_hash[:genres].find { |genre| genre[:id] == genre_id }
      genre_names << genre[:name] if genre
    end

    genre_names
  end
end