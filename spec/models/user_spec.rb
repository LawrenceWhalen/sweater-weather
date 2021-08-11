require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  describe 'relationships' do
    it { should have_many(:api_keys) }
  end

  describe 'instance methods' do
    describe '#user_and_api_key' do
      it 'returns a UserApiKeyPoro object' do
        user = User.create(
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        )
        ApiKey.add_api_key(user)

        actual = user.user_and_api_key

        expect(actual.email).to eq("whatever@example.com")
        expect(actual.api_key).to eq(User.last.api_keys[0].token)
      end
    end
  end
end