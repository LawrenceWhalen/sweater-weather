require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe '.one_weather' do
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

    describe '.brew_weather' do
      it 'returns the current weather for a location' do
        VCR.use_cassette 'weather service 2' do
          actual = WeatherService.brew_weather({ lat: '33.44', lng: '-94.04' })

          expect(actual[:weather][0][:description].class).to eq(String)
          expect(actual[:main][:temp].class).to eq(Integer).or eq(Float)
        end
      end
    end

    describe '.destination_weather' do
      it 'returns a hash of hourly and daily forecasts' do
        VCR.use_cassette 'weather service 3' do
          actual = WeatherService.destination_weather({ lat: '33.44', lng: '-94.04' })

          expect(actual[:hourly].class).to eq(Array)
          expect(actual[:hourly].length).to eq(48)
          expect(actual[:daily].class).to eq(Array)
          expect(actual[:daily].length).to eq(8)
        end
      end
    end
  end
end