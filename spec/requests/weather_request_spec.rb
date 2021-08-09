require 'rails_helper'

RSpec.description 'weather_request' do
  describe 'get forecast' do
    it 'returns a hash object with weather data' do
      VCR.use_cassette 'weather_request_1' do
        get '/api/vi/forecast?location=denver,co'

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual.keys).to eq([:current_weather, :daily_weather, :hourly_weather]
        expect(actual[:current_weather].keys).to eq([
          :datetime, :sunrise, :sunset, 
          :temperature, :feels_like, :humidity, 
          :uvi, :visibility, :conditions, :icon 
        ])
        expect(actual[:daily_weather].keys).to eq([
          :date, :sunrise, :sunset, :max_temp, 
          :min_temp, :humidity, :conditions, :icon 
        ])
        expect(actual[:hourly_weather].keys).to eq([
          :time, :temperature, :conditions, :icon
        ])
      end
    end
  end
end