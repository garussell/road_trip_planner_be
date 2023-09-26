# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapQuestService, :vcr do
  describe 'get_coordinates' do
    it 'returns the coordinates for a location' do
      location = 'denver,co'
      service = MapQuestService.get_coordinates(location)

      expect(service).to be_a(Hash)
      expect(service).to have_key(:results)

      expect(service[:results]).to be_a(Array)
      expect(service[:results][0]).to be_a(Hash)

      expect(service[:results][0]).to have_key(:locations)
      expect(service[:results][0][:locations]).to be_a(Array)

      expect(service[:results][0][:locations][0]).to have_key(:latLng)
      expect(service[:results][0][:locations][0][:latLng]).to be_a(Hash)

      expect(service[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(service[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)

      expect(service[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(service[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end
