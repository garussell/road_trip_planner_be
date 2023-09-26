# frozen_string_literal: true

class MapQuestService
  def self.get_directions(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end

  def self.get_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = Rails.application.credentials.map_quest[:key]
    end
  end
end
