class BookSearchFacade
  def initialize(params)
    @location = params[:location]
    @quantity = params[:quantity]
  end
end