# frozen_string_literal: true

module Api
  module V0
    class RoadTripController < ApplicationController
      def create
        user = User.authenticate(params[:api_key])

        return render_unauthorized unless user

        return render_invalid_parameters unless valid_road_trip_params?

        road_trip = RoadTripFacade.create_road_trip(road_trip_params)

        if road_trip.travel_time.nil? || road_trip.weather_at_eta.nil?
          render json: ErrorSerializer.format_errors('Impossible Route'), status: 404
        else
          render json: RoadTripSerializer.new(road_trip), status: 200
        end
      end

      private

      def road_trip_params
        params.permit(:origin, :destination, :units, :api_key)
      end

      def valid_road_trip_params?
        !road_trip_params[:origin].empty? && !road_trip_params[:destination].empty?
      end

      def render_unauthorized
        render json: ErrorSerializer.format_errors('Unauthorized'), status: 401
      end

      def render_invalid_parameters
        render json: ErrorSerializer.format_errors('Invalid Parameters'), status: 422
      end
    end
  end
end
