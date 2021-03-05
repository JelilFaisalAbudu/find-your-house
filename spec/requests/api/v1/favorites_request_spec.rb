require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  let(:houses) { create_list(:house, 45) }
  let(:users) { create_list(:user, 23) }
  let(:favorites) { create_list(:favorite, 15) }
  let(:user_id) { users.first.id } 

  describe 'GET /api/v1/users/:id/favorites' do
    before { get "/api/v1/users/#{user_id}/favorites" }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(response).to(have_http_status(200))
      end
    end
  end
end
