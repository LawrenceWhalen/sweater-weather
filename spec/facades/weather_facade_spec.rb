require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    describe '.weather_return' do
      describe 'good coordinates' do
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
      describe 'bad coordinates' do
        it 'returns an error message' do
          VCR.use_cassette 'weather_facade_3' do
            actual = WeatherFacade.weather_return('asdjfasd;fasjdf;lak,DC')

            expect(actual[:error][0][:location]).to eq('city not found')
          end
        end
      end
    end

    describe '.current_brew' do
      it 'returns the summary and temp for a location' do
        VCR.use_cassette 'weather facade 2' do
          actual = WeatherFacade.current_brew('Denver,CO')

          expect(actual.class).to eq(Hash)
          expect(actual[:summary].class).to eq(String)
          expect(actual[:temperature].class).to eq(String)
        end
      end
    end

    describe '.eta_weather' do
      describe 'happy path' do
        it 'returns temp and conditions for arrival time' do
          VCR.use_cassette 'weather facade 4' do
            actual = WeatherFacade.eta_weather('Denver, CO', 24)

            expect(actual[:temperature]).to eq(84.51)
            expect(actual[:conditions]).to eq('broken clouds')
          end
        end
        it 'retuns estimated weather for longest journeys' do
          VCR.use_cassette 'weather facade 5' do
            actual = WeatherFacade.eta_weather('Denver, CO', 51)

            expect(actual[:temperature]).to eq(92.19)
            expect(actual[:conditions]).to eq('light rain')
          end
        end
      end
      describe 'sad path' do
        describe 'bad coordinates' do
          it 'returns an error message' do
            VCR.use_cassette 'weather_facade_6' do
              actual = WeatherFacade.eta_weather('asdjfasd;fasjdf;lak,DC', 2)
  
              expect(actual[:error][0][:location]).to eq('city not found')
            end
          end
        end
      end
    end
  end
end