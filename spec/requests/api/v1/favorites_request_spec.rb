require 'rails_helper'

RSpec.describe 'Api::V1::Favorites', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:houses) { create_list(:house, 10) }
  let(:house_id) { house.first.id }
  let(:favorites) { create(:favorite, user_id: user_id, house_id: house_id) }

  describe 'GET /api/v1/users/:id/favorites' do
    before { get "/api/v1/users/#{user_id}/favorites" }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(response).to(have_http_status(200))
      end

      # it 'returns the user\'s favorites' do
      #   p "Logging Response: #{json}"
      #   expect(json).not_to be_empty

      # end
    end
    context 'when user does not exist' do
      let(:user_id) { 111_110 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT "api/v1/users/:user_id/favorites"
  describe 'POST api/v1/users/:user_id/favorites' do
    let(:valid_attributes) { { house_id: houses.second.id } }

    context 'when request attributes are valid' do
      before do
        post "/api/v1/users/#{user_id}/favorites",
             params: valid_attributes
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request is made' do
      before { post "/api/v1/users/#{user_id}/favorites", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: House must exist, House can't be blank/)
      end
    end
  end
end
