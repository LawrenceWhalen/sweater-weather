require 'rails_helper'

RSpec.describe PhotoService do
  describe 'class mehtods' do
    describe '.photo_by_coord' do
      describe 'happy_paht' do
        it 'returns a photos information' do
          VCR.use_cassette 'photo service 1' do
            actual = PhotoService.photo_by_coord({ lat: '33.44', lng: '-94.04' }, 'texarkana')

            expect(actual[:photos][:photo][0][:id].class).to eq(String)
            expect(actual[:photos][:photo][0][:secret].class).to eq(String)
            expect(actual[:photos][:photo][0][:server].class).to eq(String)
            expect(actual[:photos][:photo][0][:owner].class).to eq(String)
          end
        end
      end
    end
  end
end