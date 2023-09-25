require 'rails_helper'

RSpec.describe Image, type: :poros do
  describe "initialize", :vcr do
    it "creates an image object" do
      location = "denver,co"
      data = UnsplashFacade.get_image(location)

      expect(data).to be_a(Image)
      expect(data.id).to eq(nil)

      expect(data.image).to be_a(Hash)
    end
  end
end