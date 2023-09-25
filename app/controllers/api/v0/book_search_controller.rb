class Api::V0::BookSearchController < ApplicationController
  before_action :validate_location, only: [:index]

  def index
    book_search = BookSearchFacade.new(book_search_params).get_books
    render json: BookSearchSerializer.new(book_search)
  end

  private 

  def book_search_params
    params.permit(:location, :quantity)
  end

  def validate_location
    unless real_location?(params[:location])
      render json: ErrorSerializer.format_errors("Invalid Location Parameter"), status: 422
    end
  end

  def real_location?(location)
    check_location = MapQuestFacade.new(location)
    result = check_location.get_travel_time(location)
    result.formatted_time.present?
  end
end
