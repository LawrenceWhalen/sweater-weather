require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    describe '.weather_return' do
      it 'returns a weather object' do
        VCR.use_cassette 'weather_facade_1' do
          actual = WeatherFacade.weather_return('Denver,CO')
          
          expect(actual.current_weather).to_not eq(nil)
          expect(actual.daily_weather).to_not eq(nil)
          expect(actual.hourly_weather).to_not eq(nil)
          expect(actual.current_weather.count).to eq(10)
          expect(actual.current_weather[:datetime].class).to eq(Time)
          expect(actual.current_weather[:sunrise].class).to eq(Time)
          expect(actual.current_weather[:sunset].class).to eq(Time)
          expect(actual.current_weather[:temperature].class).to eq(Float).or eq(Integer)
          expect(actual.current_weather[:feels_like].class).to eq(Float).or eq(Integer)
          expect(actual.current_weather[:humidity].class).to eq(Float).or eq(Integer)
          expect(actual.current_weather[:uvi].class).to eq(Float).or eq(Integer)
          expect(actual.current_weather[:visibility].class).to eq(Float).or eq(Integer)
          expect(actual.current_weather[:conditions].class).to eq(String)
          expect(actual.current_weather[:icon].class).to eq(String)
          expect(actual.daily_weather.count).to eq(5)
          expect(actual.daily_weather[0].keys.count).to eq(7)
          expect(actual.daily_weather[0][:date].class).to eq(String)
          expect(actual.daily_weather[0][:sunrise].class).to eq(Time)
          expect(actual.daily_weather[0][:sunset].class).to eq(Time)
          expect(actual.daily_weather[0][:max_temp].class).to eq(Float).or eq(Integer)
          expect(actual.daily_weather[0][:min_temp].class).to eq(Float).or eq(Integer)
          expect(actual.daily_weather[0][:conditions].class).to eq(String)
          expect(actual.daily_weather[0][:icon].class).to eq(String)
          expect(actual.hourly_weather.count).to eq(8)
          expect(actual.hourly_weather[0].keys.count).to eq(4)
          expect(actual.hourly_weather[0][:time].class).to eq(String)
          expect(actual.hourly_weather[0][:temperature].class).to eq(Float).or eq(Integer)
          expect(actual.hourly_weather[0][:conditions].class).to eq(String)
          expect(actual.hourly_weather[0][:icon].class).to eq(String)
        end
      end
    end
    describe '.current_brew' do
      
    end
  end
end