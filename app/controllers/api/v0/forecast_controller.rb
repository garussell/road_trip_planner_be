class Api::V0::ForecastController < ApplicationController
  def index
    location = params[:location]
    
    if location
      begin
        cache_key = "forecast-#{location}"

        cached_data = fetch_or_cache(cache_key) do
          mapquest_service = MapQuestFacade.new(location)
          coordinates = mapquest_service.get_coordinates
      
          lat = coordinates.lat
          lng = coordinates.lng
  
          ForecastFacade.new(lat, lng).forecast
        end

        render json: ForecastSerializer.new(cached_data)
      rescue 
        render json: ErrorSerializer.format_errors("Location parameter is required"), status: 400
      end
    end
  end
end
