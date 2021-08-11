require 'rails_helper'

RSpec.describe 'creating a session' do
  describe 'post: /api/v1/sessions' do
    describe 'happy path' do
      it 'returns a users email and api_key' do
        post '/api/v1/users', params: { 
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }, as: :json

        post '/api/v1/sessions', params: { 
          email: "whatever@example.com",
          password: "password",
        }, as: :json

        actual = JSON.parse(response.body, symbolize_names: true)

        expect(actual[:data][:type]).to eq('users')
        expect(actual[:data][:id]).to eq(User.last.id.to_s)
        expect(actual[:data][:attributes][:email]).to eq("whatever@example.com")
        expect(actual[:data][:attributes][:api_key]).to eq(User.last.api_keys[0].token)
      end
    end
    describe 'sad paths' do
      describe 'user does not exist' do
        it 'returns a not found error' do
          post '/api/v1/sessions', params: { 
            email: "whatever@example.com",
            password: "password",
          }, as: :json

          actual = JSON.parse(response.body, symbolize_names: true)

          expect(actual[:error]).to eq([{
            user: 'email or password incorrect',
            :status=>"404 Not Found"
            }])
        end
      end
      describe 'incorrect password' do
        it 'returns a not found error' do
          post '/api/v1/users', params: { 
            email: "whatever@example.com",
            password: "password",
            password_confirmation: "password"
          }, as: :json
  
          post '/api/v1/sessions', params: { 
            email: "whatever@example.com",
            password: "password!",
          }, as: :json
  
          actual = JSON.parse(response.body, symbolize_names: true)

          expect(actual[:error]).to eq([{
            user: 'email or password incorrect',
            :status=>"404 Not Found"
            }])
        end
      end
    end
  end
end