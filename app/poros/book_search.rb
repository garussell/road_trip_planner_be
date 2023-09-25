class BookSearch
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(location, data)
    @destination = location
    @forecast = get_forecast
    @total_books_found = data[:numFound]
    @books = list_books(data)
  end

  def get_forecast
    coordinates = MapQuestFacade.new(@destination).get_coordinates
    results = ForecastFacade.new(coordinates.lat, coordinates.lng).forecast

    {
      summary: results.current_weather[:condition],
      temperature: results.current_weather[:temperature]
    }
  end

  def list_books(data)
    data[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title]
      }
    end
  end
end