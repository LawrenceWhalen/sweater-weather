require 'rails_helper'

RSpec.describe AaService do
  describe 'class methods' do
    describe '.by_location' do
      it 'returns a list of breweries for a given location' do
        VCR.use_cassette 'aa service 1' do
          actual = AaService.by_location({lat: 38.8977, lng: 77.0365}, 5)

          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(5)
          expect(actual[0][:id].class).to eq(Integer)
          expect(actual[0][:name].class).to eq(String)
          expect(actual[0][:brewery_type].class).to eq(String)
        end
      end
    end
  end
end