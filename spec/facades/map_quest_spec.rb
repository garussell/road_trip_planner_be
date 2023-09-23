require 'rails_helper'

RSpec.describe MapQuestFacade, :vcr do
  describe "initialize" do
    it "returns the coordinates per location" do
      location = "denver,co"

      facade = MapQuestFacade.new(location)
      coordinates = facade.get_coordinates

      expect(coordinates).to be_a(Coordinates)
    end
  end
end