require 'rails_helper'

RSpec.describe RoutesFacade do
  describe 'class methods' do
    describe '.roadtrip' do
      describe 'happy path' do
        it 'returns a road trip object' do
          VCR.use_cassette 'routes facade 1' do
            actual = RoutesFacade.roadtrip({ from: 'denver,co', to: 'san fansisco,ca' })

            expect(actual.class).to eq(RoutesPoro)
            expect(actual.start_city).to eq('denver, co')
            expect(actual.end_city).to eq('san fansisco, ca')
            expect(actual.travel_time).to eq('20 hours, 20 minutes')
            expect(actual.weather_at_eta).to eq(
              temperature: 69.57,
              conditions: 'broken clouds'
            )
          end
        end
      end
      describe 'sad paths' do
        describe 'impossible routes' do
          it 'returns an impossible error' do
            VCR.use_cassette 'routes facade 2' do
              actual = RoutesFacade.roadtrip({ from: 'denver,co', to: 'london,england' })

              expect(actual[:error]).to eq([route: 'Cannot find possible route'])
            end
          end
        end
        describe 'impossible routes' do
          it 'returns an impossible error' do
            VCR.use_cassette 'routes facade 3' do
              actual = RoutesFacade.roadtrip({ from: 'denver,co', to: 'washington,dc' })

              expect(actual[:error]).to eq([route: 'All possible routes are currently closed'])
            end
          end
        end
      end
    end
  end
end