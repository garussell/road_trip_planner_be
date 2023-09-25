require 'rails_helper'

RSpec.describe LibraryService, :vcr do
  describe "get_books" do
    it "returns books for a location and quantity" do
      location = "denver,co"
      quantity = 5
      service = LibraryService.get_books(location, quantity)

      expect(service).to be_a(Hash)

      expect(service[:docs]).to be_an(Array)
      expect(service[:docs].count).to eq(5)

      expect(service[:docs][0]).to have_key(:title)
      expect(service[:docs][0][:title]).to be_a(String)

      expect(service[:docs][0]).to have_key(:isbn)
      expect(service[:docs][0][:isbn]).to be_an(Array)
    end
  end
end