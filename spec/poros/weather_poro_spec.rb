require 'rails_helper'

RSpec.describe WeatherPoro do
  describe 'class instance' do
    describe 'readers' do
      it 'returns the instance attributes' do
        actual = WeatherPoro.new(
          current_weather: 'example attributes current',
          daily_weather: 'example attributes daily',
          hourly_weather: 'example attributes hourly'
        )
        
        expect(actual.current_weather).to eq('example attributes current')
        expect(actual.daily_weather).to eq('example attributes daily')
        expect(actual.hourly_weather).to eq('example attributes hourly')
        expect(actual.id).to eq(nil)
      end
    end
  end
end