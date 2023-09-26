# frozen_string_literal: true

class Coordinates
  attr_reader :lat, :lng

  def initialize(data)
    @lat = data[:results][0][:locations][0][:latLng][:lat]
    @lng = data[:results][0][:locations][0][:latLng][:lng]
  end
end
