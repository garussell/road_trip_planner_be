require 'rails_helper'

RSpec.describe BookSearchFacade, :vcr do
  before do
    @book_search = BookSearchFacade.new({location: "denver,co", quantity: 5})
  end

  describe "initialize" do
    it "exists" do
      expect(@book_search).to be_a(BookSearchFacade)
    
      results = @book_search.get_books

      expect(results).to be_a(BookSearch)
      expect(results.id).to eq(nil)
      expect(results.destination).to eq("denver,co")
      expect(results.forecast).to be_a(Hash)
      expect(results.forecast[:summary]).to be_a(String)
      expect(results.forecast[:temperature]).to be_a(String)
      expect(results.total_books_found).to be_a(Integer)
    end
  end
end