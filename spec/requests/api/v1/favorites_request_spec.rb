require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:houses) { create(:house) }
  let(:house_id) { house.id } 
  let(:favorites) { create(:favorite, user_id: user_id, house_id: house_id) }
  


  describe 'GET /api/v1/users/:id/favorites' do
    before { get "/api/v1/users/#{user_id}/favorites" }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(response).to(have_http_status(200))
      end
    end

    it 'returns the user\'s favorites' do
      # Note `json` is a custom helper to parse JSON responses
      # expect(json).not_to be_empty
      # expect(json.size).to eq(15)
    end
  end
end
