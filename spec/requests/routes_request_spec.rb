require 'rails_helper'

RSpec.describe 'route request' do
  describe 'get /api/v1/routes' do
    describe 'happy path' do
      it 'returns route information' do
        VCR.use_cassette 'routes request 1' do
          post api_v1_users_path, params: { 
            email: "whatever@example.com",
            password: "password",
            password_confirmation: "password"
          }, as: :json
  
          
          api_key = ApiKey.first.token

          post api_v1_road_trip_index_path, params: { 
            origin: "Denver,CO",
            destination: "Pueblo,CO",
            api_key: api_key
          }, as: :json
  
          actual = JSON.parse(response.body, symbolize_names: true)
          trip_info = actual[:data][:attributes]

          expect(actual[:data][:id]).to eq(nil)
          expect(actual[:data][:type]).to eq('roadtrip')
          expect(trip_info[:start_city]).to eq('Denver, CO')
          expect(trip_info[:end_city]).to eq('Pueblo, CO')
          expect(trip_info[:travel_time]).to eq('01 hours, 55 minutes')
          expect(trip_info[:weather_at_eta][:temperature]).to eq(95.16)
          expect(trip_info[:weather_at_eta][:conditions]).to eq('clear sky')
        end
      end
    end
    describe 'sad paths' do
      describe 'incorrect/missin api_key' do
        it 'returns a missing api key error' do
          VCR.use_cassette 'missing api key' do
            post api_v1_users_path, params: { 
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }, as: :json
    
            post api_v1_road_trip_index_path, params: { 
              origin: "Denver,CO",
              destination: "Pueblo,CO",
              api_key: "fakeapi"
            }, as: :json

            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error]).to eq([api_key: 'api key is missing or incorrect'])
          end
        end
      end
      describe 'impossible path' do
        it 'returns impossible path' do
          VCR.use_cassette 'routes request 2' do
            post api_v1_users_path, params: { 
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }, as: :json
    
            api_key = ApiKey.first.token

            post api_v1_road_trip_index_path, params: { 
              origin: "Denver,CO",
              destination: "London,England",
              api_key: api_key
            }, as: :json
    
            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error]).to eq([route: 'Cannot find possible route'])
          end
        end
      end
      describe 'closed path' do
        it 'returns closed path' do
          VCR.use_cassette 'routes request 3' do
            post api_v1_users_path, params: { 
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }, as: :json
    
            api_key = ApiKey.first.token

            post api_v1_road_trip_index_path, params: { 
              origin: "Denver,CO",
              destination: "Washington,DC",
              api_key: api_key
            }, as: :json
    
            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error]).to eq([route: 'All possible routes are currently closed'])
          end
        end
      end
      describe 'bad city formatting' do
        it 'returns bad city formatting' do
          VCR.use_cassette 'routes request 4' do
            post api_v1_users_path, params: { 
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }, as: :json
    
            api_key = ApiKey.first.token

            post api_v1_road_trip_index_path, params: { 
              origin: "Denver,CO",
              destination: "WashingtonDC",
              api_key: api_key
            }, as: :json
    
            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error]).to eq([{:route=>"All possible routes are currently closed"}])
          end
        end
      end
      describe 'bad city' do
        it 'returns city not found' do
          VCR.use_cassette 'routes request 5' do
            post api_v1_users_path, params: { 
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
            }, as: :json
    
            api_key = ApiKey.first.token

            post api_v1_road_trip_index_path, params: { 
              origin: "Denver,CO",
              destination: "asdjfasd;fasjdf;lak,DC",
              api_key: api_key
            }, as: :json
    
            actual = JSON.parse(response.body, symbolize_names: true)

            expect(actual[:error]).to eq([{:route=>"Cannot find possible route"}])
          end
        end
      end
    end
  end
end