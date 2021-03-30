require 'rails_helper'

RSpec.describe 'Api::V1::Favorites', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:house) do
    House.create(
      name: Faker::Restaurant.name,
      category: Faker::Restaurant.type,
      description: Faker::Restaurant.description,
      photo_url: Faker::Internet.url
    )
  end

  let(:house_id) { house.id }
  let(:favorite) { user.favorites.create(house_id: house_id) }
  let(:favorite_id) { favorite.id }
  let(:headers) { valid_headers }

  describe 'GET /api/v1/users/:id/favorites' do
    before { get "/api/v1/users/#{user_id}/favorites", params: {}, headers: headers }

    context 'when the user record exists' do
      it 'returns the user' do
        expect(response).to(have_http_status(200))
      end
    end
  end

  # Test suite for POST "api/v1/users/:user_id/favorites"
  describe 'POST api/v1/users/:user_id/favorites' do
    let(:valid_attributes) { { house_id: house.id }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/api/v1/users/#{user_id}/favorites",
             params: valid_attributes,
             headers: headers
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request is made' do
      before { post "/api/v1/users/#{user_id}/favorites", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /api/v1/users/:user_id/favorites/:id
  describe 'DELETE /api/v1/users/:user_id/favorites/:id' do
    context 'With proper user authorization' do
      before do
        delete "/api/v1/users/#{user_id}/favorites/#{favorite_id}",
               params: {},
               headers: headers
      end
      it 'removes favorite item from the list' do
        expect(response).to(have_http_status(204))
      end
    end

    context 'With improper user authorization' do
      before do
        delete "/api/v1/users/#{user_id}/favorites/#{favorite_id}"
        # headers: headers
      end
      it 'removes favorite item from the list' do
        expect(response).to(have_http_status(422))
      end
    end
  end
end
