require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  # Initialize the test data from the factory
  let(:valid_user_attributes) do
    {
      name: 'John Doe',
      email: 'johndoe@example.com',
      password: '1234567890',
      password_confirmation: '1234567890'
    }
  end
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'POST /api/v1/signup' do
    context 'when signup request is valid' do
      before do
        post '/api/v1/signup',
             params: valid_user_attributes.to_json,
             headers: headers
      end

      it 'creates a new user' do
        expect(response).to(have_http_status(201))
      end

      it 'returns success message' do
        expect(json['message']).to(match(/Account successfully created/))
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to(be_nil)
      end
    end

    context 'when signup request is invalid' do
      before { post '/api/v1/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to(have_http_status(422))
      end

      it 'returns a failure message' do
        expect(json['message']).to(include('Validation failed:'))
      end
    end
  end
end
