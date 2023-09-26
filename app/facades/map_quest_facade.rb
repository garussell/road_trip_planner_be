class MapQuestFacade

  def initialize(location)
    @location = location
  end

  def get_coordinates
    data = MapQuestService.get_coordinates(@location)
    Coordinates.new(data)
  end

  def get_time_object(destination)
    data = MapQuestService.get_directions(@location, destination)
    TravelTime.new(data)
  end
end