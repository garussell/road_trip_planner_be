# frozen_string_literal: true

class BookSearchFacade
  def initialize(params)
    @location = params[:location]
    @quantity = params[:quantity]
    @units = params[:units]
  end

  def get_books
    data = LibraryService.get_books(@location, 5)
    olids = data[:docs].map { |book| book[:edition_key] }.flatten
    previews = LibraryService.get_preview(olids)
  
    books_with_previews = data[:docs].zip(previews)

    BookSearch.new(@location, books_with_previews, @units)
  end  
end
