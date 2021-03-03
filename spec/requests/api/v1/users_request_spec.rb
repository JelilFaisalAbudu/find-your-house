require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  # Initialize the test data from the factory
  let(:users) { create_list(:user, 20) }
  let(:fifth_user) { users.fifth }


  # Test suite for POST /users
  describe 'POST api/v1/users' do

    # Create a valid payload
    let(:new_user) { 
       {
        name: 'John Doe',
        email: 'johndoe@exaple.com',
        password: 'a_strong_password',
        password_confirmation: 'a_strong_password'
      }
    }

    context 'when the new user request is valid' do
      before { post  '/api/v1/users', params: { user: new_user } }

      it 'creates a new user' do
        expect(json['name']).to(eq('John Doe')) 
      end

      it 'returns status code 201' do
        expect(response).to(have_http_status(201))  
      end
    end
    
    context 'when a user request is invalid' do
      
      before { post '/api/v1/users', params: { user: { name: 'Forbidden New User' } } }

      it 'returns status code 422' do
        expect(response).to(have_http_status(422))
      end
      
      it 'returns a validation failure message' do
        expect(json['email']).to(include('is invalid'))  
      end
    end

    context 'when an email already exist' do
      let(:strong_pass) { 'm8_it_strong_@anytime' }
      let(:another_new_user) {
        {
          name: 'Jason Bourne',
          email: fifth_user['email'],
          password: strong_pass,
          password_confirmation: strong_pass
        }
      }
      before { post '/api/v1/users', params: { user: another_new_user } }

      it 'returns status code 422' do
        expect(response).to(have_http_status(422))
      end
      
      it 'returns an email validation failure message' do
        expect(json['email']).to(include('has already been taken'))  
      end
    end
  end
  
end
