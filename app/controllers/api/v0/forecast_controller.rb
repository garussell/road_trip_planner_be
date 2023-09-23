class Api::V0::ForecastController < ApplicationController
  def index
    location = params[:location]
    if location
      begin
        mapquest_service = MapQuestFacade.new(location)
        coordinates = mapquest_service.get_coordinates
    
        lat = coordinates.lat
        lng = coordinates.lng
  
        result_objects = ForecastFacade.new(lat, lng).forecast
        render json: ForecastSerializer.new(result_objects)

      rescue 
        render json: ErrorSerializer.format_errors("Location parameter is required"), status: 400
      end
    end
  end
end
