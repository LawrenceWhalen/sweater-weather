require 'rails_helper'

RSpec.describe 'weather_request' do
  describe 'get forecast' do
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
end