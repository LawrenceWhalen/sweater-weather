require 'rails_helper'

RSpec.describe RoutesPoro do
  describe 'class instance' do
    describe 'readers' do
      it 'returns the instance attributes' do
        actual = RoutesPoro.new(
          start_city: 'denver, co',
          end_city: 'pueblo, co',
          travel_time: '2 hours, 15 minutes',
          weather: { example: 'weather example'}
        )
        
        expect(actual.start_city).to eq('denver, co')
        expect(actual.end_city).to eq('pueblo, co')
        expect(actual.travel_time).to eq('2 hours, 15 minutes')
        expect(actual.weather_at_eta[:example]).to eq('weather example')
        expect(actual.id).to eq(nil)
      end
    end
  end
end