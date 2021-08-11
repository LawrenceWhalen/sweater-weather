require 'rails_helper'

RSpec.describe UserApiKeyPoro do
  describe 'class instance' do
    describe 'readers' do
      it 'returns the instance attributes' do
        actual = UserApiKeyPoro.new(
          email: "whatever@example.com",
          api_key: 'sample_api_key'
        )
        
        expect(actual.email).to eq("whatever@example.com")
        expect(actual.api_key).to eq('sample_api_key')
      end
    end
  end
end