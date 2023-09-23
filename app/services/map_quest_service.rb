class MapQuestService

  def self.get_coordinates(location)
    get_url("?location=#{location}")
  end

  def self.get_url(url)
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address") do |f|
      f.params['key'] = Rails.application.credentials.map_quest[:key]
    end
  end
end