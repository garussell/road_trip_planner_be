class MapQuestFacade

  def initialize(location)
    @location = location
  end

  def get_coordinates
    data = MapQuestService.get_coordinates(@location)
    Coordinates.new(data)
  end

  def get_travel_time(destination)
    data = MapQuestService.get_directions(@location, destination)
    TravelTime.new(data)
  end
end