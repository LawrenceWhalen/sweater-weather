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
            actual = GeoFacade.lat_lng("asdjfasd;fasjdf;lak,DC")

            expect(actual.class).to eq(Hash)
            expect(actual.keys).to eq([:error])
          end
        end
      end
    end

    describe '.route_time' do
      describe 'happy path' do
        it 'returns the seconds the trip will take' do
          VCR.use_cassette 'geo facade 3' do
            actual = GeoFacade.route_time({ from: 'denver,co', to: 'san fransisco,ca' })

            expect(actual[:route_time]).to eq(72433)
            expect(actual[:error]).to eq(nil)
          end
        end
      end
      describe 'sad paths' do
        describe 'impossible routes' do
          it 'returns an impossible error' do
            VCR.use_cassette 'geo facade 4' do
              actual = GeoFacade.route_time({ from: 'denver,co', to: 'london,england' })

              expect(actual[:time]).to eq(nil)
              expect(actual[:error]).to eq([route: 'Cannot find possible route'])
            end
          end
        end
        describe 'impossible routes' do
          it 'returns an impossible error' do
            VCR.use_cassette 'geo facade 5' do
              actual = GeoFacade.route_time({ from: 'denver,co', to: 'washington,dc' })

              expect(actual[:time]).to eq(nil)
              expect(actual[:error]).to eq([route: 'All possible routes are currently closed'])
            end
          end
        end
      end
    end
  end
end