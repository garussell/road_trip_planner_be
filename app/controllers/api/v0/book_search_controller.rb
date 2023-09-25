class Api::V0::BookSearchController < ApplicationController
  def index
    if valid_params?
      book_search = BookSearchFacade.new(book_search_params).get_books
      render json: BookSearchSerializer.new(book_search)
    else
      render json: ErrorSerializer.format_errors("Invalid Parameters"), status: 422
    end
  end

  private 

  def book_search_params
    params.permit(:location, :quantity)
  end

  def valid_params?
    !params[:location].empty? && !params[:quantity].empty?
  end
end
