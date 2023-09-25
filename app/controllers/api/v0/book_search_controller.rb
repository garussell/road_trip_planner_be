class Api::V0::BookSearchController < ApplicationController
  def index
    if real_location?
      begin
        book_search = BookSearchFacade.new(book_search_params).get_books
        render json: BookSearchSerializer.new(book_search)
      rescue
        render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
      end
    else
      render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
    end
  end

  private 

  def book_search_params
    params.permit(:location, :quantity)
  end

  def real_location?
    location = MapQuestFacade.new(params[:location])
    result = location.get_travel_time(params[:location])
    result.formatted_time != nil
  end
end
