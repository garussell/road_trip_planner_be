class MapQuestFacade

  def initialize(location)
    @location = location
  end

  def get_coordinates
    data = MapQuestService.get_coordinates(@location)
    Coordinates.new(data)
  end
end