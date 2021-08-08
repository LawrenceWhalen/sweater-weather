require 'rails_helper'

RSpec.describe GeoService do
  describe 'class methods' do
    describe '.get_geocoding' do
      it 'returns lat and log for a given city' do
        VCR.use_cassette 'geo_service_1' do
          actual = GeoService.get_geocoding('Washington,DC')

          expect(actual[:results].first[:locations].first[:displayLatLng].class).to eq(Hash)
          expect(actual[:results].first[:locations].first[:displayLatLng].count).to eq(2)
          expect(actual[:results].first[:locations].first[:displayLatLng][:lng]).to_not eq(nil)
          expect(actual[:results].first[:locations].first[:displayLatLng][:lat]).to_not eq(nil)
        end
      end
    end
  end
end
