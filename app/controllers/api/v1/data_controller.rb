class Api::V1::DataController < ApplicationController
  before_action :validate_location, only: [:index]

  def index
    location = params[:location]
    units = params[:units]
    quantity = params[:quantity]

    begin
      weather_data = get_forecast_data(location, units)
      book_data = get_book_data(location, quantity, units)
      picture_data = get_picture_data(location)
      combined_data = OpenStruct.new(
        id: nil,
        location: location,
        weather_data: weather_data, 
        book_data: book_data, 
        picture_data: picture_data
      )

      render json: CombinedSerializer.new(combined_data)
    rescue StandardError
      render json: ErrorSerializer.format_errors('Woops, something went wrong.'), status: 400
    end
  end

  private

  def get_forecast_data(location, units)
    mapquest_service = MapQuestFacade.new(location)
    coordinates = mapquest_service.get_coordinates

    lat = coordinates.lat
    lng = coordinates.lng

    ForecastFacade.new(lat, lng, units).forecast
  end

  def get_book_data(location, quantity, units)
    data = BookSearchFacade.new(location: location, quantity: quantity, units: units)
 
    data.get_books
  end

  def get_picture_data(location)
    UnsplashFacade.get_image(location)
  end

  def validate_location
    unless real_location?(params[:location])
      head :bad_request
    end
  end

  def real_location?(location)
    check_location = MapQuestFacade.new(location)
    result = check_location.get_time_object(location)
    result.formatted_time.present?
  end
end
