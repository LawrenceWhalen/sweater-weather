require 'rails_helper'

RSpec.describe GeoFacade do
  describe 'class methods' do
    describe '.lat_lng' do
      it 'returns a hash with lag and lng cordinates' do
        actual = GeoFacade.lat_lng(Denver,CO)

        expect(actual.class).to eq(Hash)
        expect(actual.keys).to eq(['lat', 'lng'])
      end
    end
  end
end