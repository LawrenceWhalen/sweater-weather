require 'rails_helper'

RSpec.describe PhotoPoro do
  describe 'class instance' do
    describe 'readers' do
      it 'returns the instance attributes' do
        actual = PhotoPoro.new(
          location: 'denver,co',
          image_url: 'www.flickr.com',
          credit: { example: 'credit here'}
        )
        
        expect(actual.location).to eq('denver,co')
        expect(actual.image_url).to eq('www.flickr.com')
        expect(actual.credit[:example]).to eq('credit here')
        expect(actual.id).to eq(nil)
      end
    end
  end
end