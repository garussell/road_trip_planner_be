class BookSearch
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(location, data)
    @id = nil
    @destination = location
    @forecast = get_forecast
    @total_books_found = data[:numFound]
    @books = list_books(data)
  end

  def get_forecast
    coordinates = MapQuestFacade.new(@destination).get_coordinates
    results = ForecastFacade.new(coordinates.lat, coordinates.lng).forecast

    {
      summary: "#{results.current_weather[:condition]} #{insert_summary}",
      temperature: "#{results.current_weather[:temperature]} F"
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

  private

  def insert_summary
    summary = [
      "with a chance of rainbows",
      "with a hint of nothingness",
      "with a chance of meatballs",
      "with a chance of happiness",
      "with a possibility of flying pigs",
      "with a dash of dinner",
      "with a flurry of magic",
      "with dreams",
      "with a touch of destiny",
      "with a mystical aura"
    ]
    summary.sample
  end
end