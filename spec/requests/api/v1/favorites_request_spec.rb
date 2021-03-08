require 'rails_helper'

RSpec.describe 'Api::V1::Favorites', type: :request do
  let(:users) { create_list(:user, 24) }
  let(:user) { users.second }
  let(:user_id) { user.id }
  let(:houses) { create_list(:house, 10) }
  let(:house_id) { houses.first.id }
  let(:favorites) { create_list(:favorite, 5, user_id: user_id, house_id: house_id) }
  let(:favorite_id) { favorites.last.id }

  describe 'GET /api/v1/users/:id/favorites' do
    before { get "/api/v1/users/#{user_id}/favorites" }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(response).to(have_http_status(200))
      end
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
        params: valid_attributes,
        headers: {
          Authorization: JsonWebToken.encode(user_id: user_id)
        }
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request is made' do
      before { post "/api/v1/users/#{user_id}/favorites", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(403)
      end
    end
  end

  # Test suite for DELETE /api/v1/users/:user_id/favorites/:id
  describe 'DELETE /api/v1/users/:user_id/favorites/:id' do
    context 'With proper user authorization' do
      before do 
        delete "/api/v1/users/#{user_id}/favorites/#{favorite_id}",
        headers: {
          Authorization: JsonWebToken.encode(user_id: user_id)
        }
      end
      it 'removes favorite item from the list' do
        expect(response).to(have_http_status(204))  
      end
    end
    
    context 'With improper user authorization' do
      before do 
        delete "/api/v1/users/#{user_id}/favorites/#{favorite_id}",
        headers: {
          Authorization: JsonWebToken.encode(user_id: users.last.id)
        }
      end
      it 'removes favorite item from the list' do
        expect(response).to(have_http_status(403))  
      end
    end
  end
  
end
