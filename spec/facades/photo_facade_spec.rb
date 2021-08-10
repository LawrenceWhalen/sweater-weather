require 'rails_helper'

RSpec.describe PhotoFacade do
  describe 'class methods' do
    describe '.retrieve_photo_with_credit' do
      describe 'happy_path' do
        it 'returns a full photo object' do
          VCR.use_cassette 'photo facade 1' do
            actual = PhotoFacade.retrieve_photo_with_credit('washington,dc')

            expect(actual.id).to eq(nil)
            expect(actual.location).to eq('washington,dc')
            expect((actual.image_url).class).to eq(String)
            expect(actual.credit.keys).to eq([:source, :author, :website])
            expect(actual.credit[:source].to eq('www.flickr.com')
          end
        end
      end
      describe 'sad_path' do
        it 'returns an error' do
          VCR.use_cassette 'photo facade 2' do
            actual
          end
        end
      end
    end
    describe '.find_photo' do
      describe 'happy path' do
        it 'returns an image url' do
          VCR.use_cassette 'photo facade 3' do
            actual = PhotoFacade.find_photo({ lat: '33.44', lng: '-94.04' })

            expect(actual.class).to eq(String)
          end
        end
      end
      describe 'sad path' do
        it 'returns an error' do
          VCR.use_cassette 'photo facade 4' do
            actual = PhotoFacade.find_photo({ lat: '-67.337480', lng: '198.818353' })

            expect(actual[:error]).to eq('No picture found for location')
          end
        end
      end
    end
    describe '.find_author' do
      it 'returns a hash of the artists information' do
        actual = PhotoFacade.find_author('49530087@N08')

        expect(actaul[:source]).to eq('www.flickr.com')
        expect(actual[:name]).to eq("The United Nations Children's Fund")
        expect(actual[:website]).to eq('http://www.unicef.org/')
      end
    end
  end
end