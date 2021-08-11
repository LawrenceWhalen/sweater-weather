require 'rails_helper'

RSpec.describe 'User creation' do
  describe 'post api/v1/user' do
    describe 'happy path' do
      it 'returns a reponse with an api_key' do
        post '/api/v1/users', params: { 
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }, as: :json

        actual = JSON.parse(response.body, symbolize_names: true)
        
        expect(actual[:data][:type]).to eq('users')
        expect(actual[:data][:id]).to eq(User.last.id.to_s)
        expect(actual[:data][:attributes][:email]).to eq("whatever@example.com")
        expect(actual[:data][:attributes][:api_key]).to eq(User.last.api_keys[0].token)
      end
    end
    describe 'sad path' do
      describe 'missing params' do
        it 'returns an error for missing params' do
          post '/api/v1/users', params: { 
            email: "",
            password: "",
            password_confirmation: ""
          }, as: :json

          actual = JSON.parse(response.body, symbolize_names: true)

          expect(actual[:error]).to eq([{
            :password=>["can't be blank"], 
            :password_digest=>["can't be blank"], 
            :email=>["can't be blank"]
            }])
        end
      end
      describe 'passwords do not match' do
        it 'returns an error for password not confirmed' do
          post '/api/v1/users', params: { 
            email: "whatever@example.com",
            password: "password",
            password_confirmation: "password!"
          }, as: :json

          actual = JSON.parse(response.body, symbolize_names: true)

          expect(actual[:error]).to eq([{
            :password_confirmation=>["doesn't match Password"]
            }])
        end
      end
      describe 'repeated email' do
        it 'returns email in use error' do
          post '/api/v1/users', params: { 
            email: "whatever@example.com",
            password: "password",
            password_confirmation: "password"
          }, as: :json

          post '/api/v1/users', params: { 
            email: "whatever@example.com",
            password: "password",
            password_confirmation: "password"
          }, as: :json

          actual = JSON.parse(response.body, symbolize_names: true)
          
          expect(actual[:error]).to eq([{
            :email=>["has already been taken"]
            }])
        end
      end
    end
  end
end