# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Coordinates', type: :poros do
  describe 'initialize' do
    it 'receives data from mapquest that includes lat and lng' do
      raw_data = { info: { statuscode: 0, copyright: { text: '© 2023 MapQuest, Inc.', imageUrl: 'http://api.mqcdn.com/res/mqlogo.gif', imageAltText: '© 2023 MapQuest, Inc.' }, messages: [] },
                   options: { maxResults: -1, ignoreLatLngInput: false },
                   results: [{ providedLocation: { location: 'denver,co' },
                               locations: [{ street: '',
                                             adminArea6: '',
                                             adminArea6Type: 'Neighborhood',
                                             adminArea5: 'Denver',
                                             adminArea5Type: 'City',
                                             adminArea4: 'Denver',
                                             adminArea4Type: 'County',
                                             adminArea3: 'CO',
                                             adminArea3Type: 'State',
                                             adminArea1: 'US',
                                             adminArea1Type: 'Country',
                                             postalCode: '',
                                             geocodeQualityCode: 'A5XAX',
                                             geocodeQuality: 'CITY',
                                             dragPoint: false,
                                             sideOfStreet: 'N',
                                             linkId: '0',
                                             unknownInput: '',
                                             type: 's',
                                             latLng: { lat: 39.74001, lng: -104.99202 },
                                             displayLatLng: { lat: 39.74001, lng: -104.99202 },
                                             mapUrl: '' }] }] }

      coordinates = Coordinates.new(raw_data)

      expect(coordinates).to be_a(Coordinates)
      expect(coordinates.lat).to eq(39.74001)
      expect(coordinates.lng).to eq(-104.99202)
    end
  end
end
