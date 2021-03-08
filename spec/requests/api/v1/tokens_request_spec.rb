require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:password) { user.password }

  describe 'POST /api/v1/tokens' do
    before { post '/api/v1/tokens', params: { user: { email: email, password: password } } }

    context 'when a user credentials are valid' do
      it 'creates the JWT token for the user' do
        expect(response).to(have_http_status(201))
      end

      it 'includes the user token' do
        expect(json['token']).not_to(be_nil)
      end
    end

    context 'when a user credentials are invalid' do
      let(:password) { '4ffejsx,vgn' }
      it 'doesn\'t create the user token' do
        expect(response).to(have_http_status(:unauthorized))
      end

      it 'returns no token' do
        expect(json['token']).to(eq(nil))
      end
    end
  end
end
