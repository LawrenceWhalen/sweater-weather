require 'rails_helper'

RSpec.describe 'weather_request' do
  describe 'get forecast' do
    describe 'good coordinates' do
      it 'returns a hash object with weather data' do
        VCR.use_cassette 'weather_request_1' do
          get api_v1_forecast_index_path(location: 'denver,co')

          actual = JSON.parse(response.body, symbolize_names: true)

          expect(actual[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
          expect(actual[:data][:id]).to eq(nil)
          expect(actual[:data][:type]).to eq('forecast')
          expect(actual[:data][:attributes][:current_weather].keys).to eq([
            :datetime, :sunrise, :sunset, 
            :temperature, :feels_like, :humidity, 
            :uvi, :visibility, :conditions, :icon 
          ])
          expect(actual[:data][:attributes][:daily_weather][0].keys).to eq([
            :date, :sunrise, :sunset, :max_temp, 
            :min_temp, :conditions, :icon 
          ])
          expect(actual[:data][:attributes][:hourly_weather][0].keys).to eq([
            :time, :temperature, :conditions, :icon
          ])
        end
      end
    end
    describe 'incorrect querries' do
      describe 'incorrect formatting' do
        it 'returns an incorrect format error' do
          VCR.use_cassette 'weather request 2' do
            get api_v1_forecast_index_path(location: 'denverco')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("invalid location format")
          end
        end
      end
      describe 'incorrect state' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'weather request 3' do
            get api_v1_forecast_index_path(location: 'denver,xo')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("invalid state code")
          end
        end
      end
      describe 'no city provided' do
        it 'returns an incorrect state error' do
          VCR.use_cassette 'weather request 4' do
            get api_v1_forecast_index_path(location: ',co')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("must include city")
          end
        end
      end
      describe 'bad city provided' do
        it 'returns an error for city not found' do
          VCR.use_cassette 'weather request 5' do
            get api_v1_forecast_index_path(location: 'asdjfasd;fasjdf;lak,DC')

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error][0][:location]).to eq("city not found")
          end
        end
      end
    end
  end
end