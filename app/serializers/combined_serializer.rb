class CombinedSerializer
  include JSONAPI::Serializer
  set_type 'combined_data'
  
  attributes :id, :location, :weather_data, :book_data, :picture_data

  def id
    object[:id] || SecureRandom.uuid
  end

  def weather_data
    ForecastSerializer.new(object[:weather_data])
  end

  def book_data
    BookSerializer.new(object[:book_data])
  end

  def picture_data
    BackgroundSerializer.new(object[:picture_data])
  end
end