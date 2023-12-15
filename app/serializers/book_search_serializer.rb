# frozen_string_literal: true

class BookSearchSerializer
  include JSONAPI::Serializer
  set_type :books

  attributes :destination, :forecast, :books
end
