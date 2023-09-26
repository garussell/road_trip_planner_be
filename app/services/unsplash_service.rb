# frozen_string_literal: true

class UnsplashService
  def self.get_image(location)
    get_url("/search/photos?query=#{location}&per_page=1")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params['client_id'] = Rails.application.credentials.unsplash[:client_id]
    end
  end
end
