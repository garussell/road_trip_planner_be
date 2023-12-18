class MovieSerializer
  include JSONAPI::Serializer

  set_type 'movie'

  attributes :id, :title, :genres, :overview, :release_date, :vote_average, :vote_count, :poster_path
end