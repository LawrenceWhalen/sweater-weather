require 'rails_helper'

RSpec.describe BreweryFacade do
  describe 'class methods' do
    describe '.by_city' do
      describe 'good location' do
        it 'returns a brewery poro for a city' do
          VCR.use_cassette 'brewery facade 1' do
            actual = BreweryFacade.by_city('denver,co', 10)

            expect(actual.id).to eq(nil)
            expect(actual.destination).to eq('denver,co')
            expect(actual.forecast[:summary].class).to eq(String)
            expect(actual.forecast[:temperature].class).to eq(String)
            expect(actual.breweries.length).to eq(10)
            expect(actual.breweries[0].length).to eq(3)
            expect(actual.breweries[0][:id].class).to eq(Integer)
            expect(actual.breweries[0][:name].class).to eq(String)
            expect(actual.breweries[0][:brewery_type].class).to eq(String)
          end
        end
      end
      describe 'bad location' do
        it 'returns an error' do
          VCR.use_cassette 'brewery facade 2' do
            actual = BreweryFacade.by_city('asdjfasd;fasjdf;lak,DC', 8)

            expect(actual[:error][0][:location]).to eq('city not found')
          end
        end
      end
    end
  end
end