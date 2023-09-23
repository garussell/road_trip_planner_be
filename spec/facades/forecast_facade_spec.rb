require 'rails_helper'

RSpec.describe ForecastFacade, :vcr do
  describe "initialize" do
    it "returns the forecast per lat and lng" do
      lat = 39.738453
      lng = -104.984853

      facade = ForecastFacade.new(lat, lng)
      forecast = facade.forecast

      expect(forecast).to be_a(Forecast)
    end
  end
end