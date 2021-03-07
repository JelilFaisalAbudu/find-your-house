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

      # it 'returns the user\'s favorites' do
      #   p "Logging Response: #{json}"
      #   expect(json).not_to be_empty
        
      # end
    end
    context 'when user does not exist' do
      let(:user_id) { 111110 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
end
