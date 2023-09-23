class ForecastFacade
  def initialize(lat, lgn)
    @lat = lat
    @lgn = lgn
  end

  def forecast
    data = ForecastService.get_forecast(@lat, @lgn)
    Forecast.new(data)
  end
end