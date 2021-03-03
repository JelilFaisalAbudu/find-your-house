require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  # Initialize the test data from the factory
  let(:users) { create_list(:user, 20) }
  let(:fifth_user) { users.fifth }
  let(:user_id) { users.fifth.id }

  # Test suite for GET /todos/:id
  describe 'GET /api/v1/users/:id' do
    before { get "/api/v1/users/#{user_id}" }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(json).not_to(be_empty)
        expect(json['id']).to(eq(user_id))
      end

      it 'returns status code 200' do
        expect(response).to(have_http_status(200))
      end
    end

    context 'when a user record does not exist' do
      let(:user_id) { 10_001_098 }

      it 'returns status code 404' do
        expect(response).to(have_http_status(404))
      end

      it 'returns a not found message' do
        p "Line 72 Log #{json['message']}"
        expect(json['message']).to(match(/Couldn't find User with 'id'=10001098/i))
      end
    end
  end

  # Test suite for POST /users
  describe 'POST api/v1/users' do
    # Create a valid payload
    let(:new_user) do
      {
        name: 'John Doe',
        email: 'johndoe@exaple.com',
        password: 'a_strong_password',
        password_confirmation: 'a_strong_password'
      }
    end

    context 'when the new user request is valid' do
      before { post '/api/v1/users', params: { user: new_user } }

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
        expect(json['message']).to(include('can\'t be blank'))
      end
    end

    context 'when an email already exist' do
      let(:strong_pass) { 'm8_it_strong_@anytime' }
      let(:another_new_user) do
        {
          name: 'Jason Bourne',
          email: fifth_user['email'],
          password: strong_pass,
          password_confirmation: strong_pass
        }
      end
      before { post '/api/v1/users', params: { user: another_new_user } }

      it 'returns status code 422' do
        expect(response).to(have_http_status(422))
      end

      it 'returns an email validation failure message' do
        expect(json['message']).to(include('Email has already been taken'))
      end
    end
  end
end
