require 'rails_helper'

RSpec.describe 'brewery requests' do
  describe 'GET /api/v1/breweries' do
    it 'returns a selection of breweries and weather for a city' do
      VCR.use_cassette 'brewery request 1' do
        get api_v1_breweries_index_path(location: 'denver,co', quantity: 8)

        actual = JSON.parse(response.body, symbolize_names: true)
        attributes = actual[:data][:attributes]

        expect(actual[:data][:id]).to eq(nil)
        expect(actual[:data][:type]).to eq('breweries')
        expect(actual[:data][:attributes].keys).to eq([
          :destination,
          :forecast,
          :breweries
        ])
        expect(attributes[:destination].to eq('denver,co')
        expect(attributes[:forecast].keys).to eq([:summary, :temperature])
        expect(attributes[:breweries].length).to eq(8)
        expect(attributes[:breweries][0].keys.to eq([:id, :name, :brewery_type])
      end
    end
  end
end