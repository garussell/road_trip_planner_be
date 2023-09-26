# frozen_string_literal: true

class LibraryService
  def self.get_books(location, quantity)
    get_url("search.json?q=#{location}&limit=#{quantity}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://openlibrary.org/')
  end
end
