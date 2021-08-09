require 'rails_helper'

RSpec.describe WeatherPoro do
  describe 'class instance' do
    describe 'readers' do
      it 'returns the instance attributes' do
        actual = WeatherPoro.new(
          'example attributes'
        )
        
        expect(actual.attributes).to eq('example attributes')
        expect(actual.id).to eq(nil)
      end
    end
  end
end