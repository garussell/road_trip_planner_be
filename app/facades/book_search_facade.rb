class BookSearchFacade
  def initialize(params)
    @location = params[:location]
    @quantity = params[:quantity]
  end

  def get_books
    data = LibraryService.get_books(@location, @quantity)
    BookSearch.new(@location, data)
  end
end