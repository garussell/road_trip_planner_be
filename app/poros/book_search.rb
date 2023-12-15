# frozen_string_literal: true

class BookSearch
  attr_reader :id, :destination, :forecast, :books

  def initialize(location, data, units)
    @id = nil
    @units = units unless units.nil?
    @destination = location
    @forecast = get_forecast
    @books = list_books(data) 
  end

  def get_forecast
    coordinates = MapQuestFacade.new(@destination).get_coordinates
    results = ForecastFacade.new(coordinates.lat, coordinates.lng, @units).forecast

    {
      summary: "#{results.current_weather[:condition]} #{insert_summary}",
      temperature: if @units == 'imperial' || @units.nil?
                     "#{results.current_weather[:temperature]} F"
                   elsif @units == 'metric'
                     "#{results.current_weather[:temperature]} C"
                   end
    }
  end

  def list_books(data)
    data.map do |book|
      {
        title: book[0][:title] || 'No Title Available',
        author: book[0][:author_name] || ['No Author Available'],
        publish_year: book[0][:publish_year] || ['No Publish Year Available'],
        publisher: book[0][:publisher].first || 'No Publisher Available',
        preview: book[1][1][:preview_url] || 'No Preview Available'
      }
    end
  end

  private

  def insert_summary
    summary = [
      'with a chance of rainbows',
      'with a hint of nothingness',
      'with a chance of meatballs',
      'with a chance of happiness',
      'with a possibility of things changing',
      'with a dash of panic',
      'with a flurry of magic',
      'with dreams to make happen',
      'with a touch of destiny',
      'with a mystical aura of wonder'
    ]
    summary.sample
  end
end
