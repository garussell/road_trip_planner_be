class Api::V0::BookSearchController < ApplicationController
  def index

    begin
      book_search = BookSearchFacade.new(book_search_params).get_books
      render json: BookSearchSerializer.new(book_search)
    rescue
      render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
    end
  end

  private 

  def book_search_params
    params.permit(:location, :quantity)
  end
end
