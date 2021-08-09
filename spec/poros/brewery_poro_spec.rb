require 'rails_helper'

RSpec.describe BreweryPoro do
  describe 'instance methods' do
    describe 'attr readers' do
      it 'returns the attributes assigned to the poro' do
        actual = BreweryPoro.new(
          destination: 'denver,co',
          forecast: { weather: 'weather' },
          breweries: [{ beer: 'beer' }]
        )

        expect(actual.id).to eq(nil)
        expect(actual.destination).to eq('denver,co')
        expect(actual.forecast[:weather]).to eq('weather')
        expect(actual.breweries[0][:beer]).to eq('beer')
      end
    end
  end
end