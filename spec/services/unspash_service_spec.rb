require 'rails_helper'

RSpec.describe UnsplashService, :vcr do
  describe "get_image" do
    it "retrieves image based on location" do
      location = "denver,co"
      image = UnsplashService.get_image(location)

      expect(image).to be_a(Hash)
      expect(image).to have_key(:results)

      expect(image[:results]).to be_a(Array)
      expect(image[:results][0]).to be_a(Hash)

      expect(image[:results][0]).to have_key(:urls)
      expect(image[:results][0][:urls]).to be_a(Hash)

      expect(image[:results][0][:urls]).to have_key(:raw)
      expect(image[:results][0][:urls][:raw]).to be_a(String)

      expect(image[:results][0]).to have_key(:user)
      expect(image[:results][0][:user]).to be_a(Hash)

      expect(image[:results][0][:user]).to have_key(:name)
      expect(image[:results][0][:user][:name]).to be_a(String)

      expect(image[:results][0][:user]).to have_key(:profile_image)
      expect(image[:results][0][:user][:profile_image]).to be_a(Hash)

      expect(image[:results][0][:user][:profile_image]).to have_key(:small)
      expect(image[:results][0][:user][:profile_image][:small]).to be_a(String)
    end
  end
end