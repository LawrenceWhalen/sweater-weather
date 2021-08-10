require 'rails_helper'

RSpec.describe PhotoService do
  describe 'class mehtods' do
    describe '.photo_by_coord' do
      describe 'happy_path' do
        it 'returns a photos information' do
          VCR.use_cassette 'photo service 1' do
            actual = PhotoService.photo_by_coord({ lat: '33.44', lng: '-94.04' })

            expect(actual[:photos][:photo][0][:id].class).to eq(String)
            expect(actual[:photos][:photo][0][:secret].class).to eq(String)
            expect(actual[:photos][:photo][0][:server].class).to eq(String)
            expect(actual[:photos][:photo][0][:owner].class).to eq(String)
          end
        end
      end
      describe 'sad_path' do
        it 'returns an empty photo set' do
          VCR.use_cassette 'photo service 2' do
            actual = PhotoService.photo_by_coord({ lat: '-67.337480', lng: '198.818353' })

            expect(actual[:photos][:photo]).to eq([])
          end
        end
      end
    end

    describe '.artist_account' do
      describe 'happy path' do
        it 'returns the account for a user' do
          VCR.use_cassette 'photo service 3' do
            actual = PhotoService.artist_account('49530087@N08')

            expect(actual[:profile][:first_name].class).to eq(String)
            expect(actual[:profile][:last_name].class).to eq(String)
            expect(actual[:profile][:website].class).to eq(String)
          end
        end
      end
    end
  end
end