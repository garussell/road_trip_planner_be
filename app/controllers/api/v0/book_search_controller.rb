# frozen_string_literal: true

module Api
  module V0
    class BookSearchController < ApplicationController
      before_action :validate_location, only: [:index]

      def index
        book_search = BookSearchFacade.new(book_search_params).get_books
        render json: BookSearchSerializer.new(book_search)
      end

      private

      def book_search_params
        params.permit(:location, :quantity, :units)
      end

      def validate_location
        return if real_location?(params[:location])

        render json: ErrorSerializer.format_errors('Invalid Location Parameter'), status: 422
      end

      def real_location?(location)
        check_location = MapQuestFacade.new(location)
        result = check_location.get_time_object(location)
        result.formatted_time.present?
      end
    end
  end
end
