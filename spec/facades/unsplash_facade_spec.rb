# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnsplashFacade, :vcr do
  describe 'get_image' do
    it 'returns an image object' do
      location = 'denver,co'
      expect(UnsplashFacade.get_image(location)).to be_a(Image)
      expect(UnsplashFacade.get_image(location).image).to be_a(Hash)
      expect(UnsplashFacade.get_image(location).image[:location]).to be_a(String)
      expect(UnsplashFacade.get_image(location).image[:image_url]).to be_a(String)
      expect(UnsplashFacade.get_image(location).image[:credit]).to be_a(Hash)
      expect(UnsplashFacade.get_image(location).image[:credit][:source]).to be_a(String)
      expect(UnsplashFacade.get_image(location).image[:credit][:author]).to be_a(String)
      expect(UnsplashFacade.get_image(location).image[:credit][:logo]).to be_a(String)
    end
  end
end
