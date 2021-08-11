require 'rails_helper'

RSpec.describe 'background requests' do
  describe 'GET /api/v1/backgrounds' do
    describe 'correct querry' do
      it 'returns a selection of backgrounds for a city' do
        VCR.use_cassette 'background request 1' do
          get api_v1_backgrounds_path(location: 'denver,co')

          actual = JSON.parse(response.body, symbolize_names: true)
          attributes = actual[:data][:attributes]

          expect(actual[:data][:id]).to eq(nil)
          expect(actual[:data][:type]).to eq('image')
          expect(actual[:data][:attributes].keys).to eq([
            :location,
            :image_url,
            :credit
          ])
          expect(attributes[:location]).to eq('denver,co')
          expect(attributes[:image_url].class).to eq(String)
          expect(attributes[:credit].length).to eq(3)
          expect(attributes[:credit].keys).to eq([:source, :author, :website])
        end
      end
    end
    describe 'incorrect querries' do
      describe 'incorrect formatting' do
        it 'returns an incorrect format error' do
          VCR.use_cassette 'background request 2' do
            get api_v1_backgrounds_path(location: 'denverco')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:errors][0][:location]).to eq("invalid location format")
          end
        end
      end
      describe 'incorrect state' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'background request 3' do
            get api_v1_backgrounds_path(location: 'denver,xo')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:errors][0][:location]).to eq("invalid state code")
          end
        end
      end
      describe 'no city provided' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'background request 4' do
            get api_v1_backgrounds_path(location: ',co')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:errors][0][:location]).to eq("must include city")
          end
        end
      end
      describe 'no image for city' do
        xit 'returns an incorrect state error' do
          VCR.use_cassette 'background request 5' do
            get api_v1_backgrounds_path(location: '98127398,dc')

            actual = JSON.parse(response.body, symbolize_names: true)
            binding.pry
            expect(actual[:errors][0][:location]).to eq("must include city")
          end
        end
      end
    end
  end
end