class ForecastFacade
  def initialize(lat, lgn, units)
    @lat = lat
    @lgn = lgn
    @units = units
  end

  def forecast
    data = ForecastService.get_forecast(@lat, @lgn)
    Forecast.new(data, @units)
  end
end