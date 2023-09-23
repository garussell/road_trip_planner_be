class Coordinates
  attr_reader :lat, :lng

  def initialize(data)
    # require 'pry';binding.pry
    @lat = data[:results][0][:locations][0][:latLng][:lat]
    @lng = data[:results][0][:locations][0][:latLng][:lng]
  end
end