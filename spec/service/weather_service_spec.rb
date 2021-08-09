require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe 'one_weather' do
      it 'returns the weather data for a given location' do
        VCR.use_cassette 'weather_service_1' do
          actual = WeatherService.one_weather({ lat: '33.44', lng: '-94.04' })

          expect(actual.keys).to eq([
            :lat,
            :lon,
            :timezone,
            :timezone_offset,
            :current,
            :hourly,
            :daily
          ])
        end
      end
    end
  end
end