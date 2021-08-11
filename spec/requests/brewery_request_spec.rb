require 'rails_helper'

RSpec.describe 'brewery requests' do
  describe 'GET /api/v1/breweries' do
    describe 'correct querry' do
      it 'returns a selection of breweries and weather for a city' do
        VCR.use_cassette 'brewery request 1' do
          get api_v1_breweries_path(location: 'denver,co', quantity: 8)

          actual = JSON.parse(response.body, symbolize_names: true)
          attributes = actual[:data][:attributes]

          expect(actual[:data][:id]).to eq(nil)
          expect(actual[:data][:type]).to eq('breweries')
          expect(actual[:data][:attributes].keys).to eq([
            :destination,
            :forecast,
            :breweries
          ])
          expect(attributes[:destination]).to eq('denver,co')
          expect(attributes[:forecast].keys).to eq([:summary, :temperature])
          expect(attributes[:breweries].length).to eq(8)
          expect(attributes[:breweries][0].keys).to eq([:id, :name, :brewery_type])
        end
      end
    end
    describe 'incorrect querries' do
      describe 'incorrect formatting' do
        it 'returns an incorrect format error' do
          VCR.use_cassette 'brewery request 2' do
            get api_v1_breweries_path(location: 'denverco', quantity: 8)

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("invalid location format")
          end
        end
      end
      describe 'incorrect state' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'brewery request 3' do
            get api_v1_breweries_path(location: 'denver,xo', quantity: 8)

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("invalid state code")
          end
        end
      end
      describe 'no city provided' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'brewery request 4' do
            get api_v1_breweries_path(location: ',co', quantity: 8)

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("must include city")
          end
        end
      end
      describe 'incorrect quantity' do
        it 'returns 5 breweries by default' do
          VCR.use_cassette 'brewery request 5' do
            get api_v1_breweries_path(location: 'denver,co')

            actual = JSON.parse(response.body, symbolize_names: true)

            attributes = actual[:data][:attributes]

            expect(attributes[:breweries].length).to eq(5)
          end
        end
      end
    end
  end
end