# frozen_string_literal: true

module Api
  module V0
    class ForecastController < ApplicationController
      def index
        location = params[:location]
        units = params[:units]

        return unless location

        begin
          cache_key = "forecast-#{location}"

          cached_data = fetch_or_cache(cache_key) do
            mapquest_service = MapQuestFacade.new(location)
            coordinates = mapquest_service.get_coordinates

            lat = coordinates.lat
            lng = coordinates.lng

            ForecastFacade.new(lat, lng, units).forecast
          end

          render json: ForecastSerializer.new(cached_data)
        rescue StandardError
          render json: ErrorSerializer.format_errors('Location parameter is required'), status: 400
        end
      end
    end
  end
end
