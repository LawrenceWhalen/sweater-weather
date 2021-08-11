require 'rails_helper'

RSpec.describe ApiKey do
  describe 'relationships' do
    it { should belong_to(:bearer) }
  end

  describe 'class methods' do
    describe 'happy path' do
      it 'creates an api key for a user' do
        user = User.create!(email: 'test@test.com', password: 'testing', password_confirmation: 'testing')

        ApiKey.add_api_key(user)

        actual = user.api_keys
        
        expect(actual[0].bearer_id).to eq(user.id)
        expect(actual[0].bearer_type).to eq('User')
      end
    end
  end
end