# frozen_string_literal: true

module Api
  module V0
    class BackgroundsController < ApplicationController
      def index
        location = params[:location]

        return unless location

        begin
          photo = UnsplashFacade.get_image(location)
          render json: BackgroundSerializer.new(photo)
        rescue StandardError
          render json: ErrorSerializer.format_errors('Location parameter is required'), status: 400
        end
      end
    end
  end
end
