class TravelTime
  attr_reader :formatted_time, :seconds

  def initialize(data)
    @formatted_time = data[:route][:formattedTime]
    @seconds = data[:route][:time]
  end
end