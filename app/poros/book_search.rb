class BookSearch
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(location, data, units)
    @id = nil
    @units = units
    @destination = location
    @forecast = get_forecast
    @total_books_found = data[:numFound]
    @books = list_books(data)
  end
  
  def get_forecast
    coordinates = MapQuestFacade.new(@destination).get_coordinates
    results = ForecastFacade.new(coordinates.lat, coordinates.lng, @units).forecast

    {
      summary: "#{results.current_weather[:condition]} #{insert_summary}",
      temperature:  if @units == "imperial" || @units == nil
                      "#{results.current_weather[:temperature]} F"
                    elsif @units == "metric"
                      "#{results.current_weather[:temperature]} C"
                    end
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
      "with a possibility of things changing",
      "with a dash of panic",
      "with a flurry of magic",
      "with dreams to make happen",
      "with a touch of destiny",
      "with a mystical aura of wonder"
    ]
    summary.sample
  end
end