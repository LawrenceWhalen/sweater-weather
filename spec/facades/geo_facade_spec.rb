require 'rails_helper'

RSpec.describe GeoFacade do
  describe 'class methods' do
    describe '.lat_lng' do
      describe 'good location' do
        it 'returns a hash with lag and lng cordinates' do
          VCR.use_cassette 'geo_facade_1' do
            actual = GeoFacade.lat_lng("Denver,CO")

            expect(actual.class).to eq(Hash)
            expect(actual.keys).to eq([:lat, :lng])
          end
        end
      end
      describe 'bad location' do
        it 'returns an error hash' do
          VCR.use_cassette 'geo facade 2' do
            actual = GeoFacade.lat_lng("asdkljflasjf';lsdfl;s,CO")

            expect(actual.class).to eq(Hash)
            expect(actual.keys).to eq([:error])
          end
        end
      end
    end
  end
end