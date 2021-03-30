require 'rails_helper'

RSpec.describe 'Api::V1::Houses', type: :request do
  # initialize test data
  let!(:houses) { create_list(:house, 10) }
  let(:house_id) { houses.first.id }

  describe 'GET /api/v1/houses' do
    before { get '/api/v1/houses' }
    it 'returns all houses' do
      # p "logging json #{json}"
      expect(response).to(have_http_status(200))
    end

    it 'returns the total houses' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end
  describe 'POST /api/v1/houses' do
    let(:valid_house_attributes) do
      {
        name: Faker::Restaurant.name,
        category: Faker::Restaurant.type,
        description: Faker::Restaurant.description,
        photo_url: Faker::Internet.url
      }
    end

    context 'when the post request is valid' do
      before { post '/api/v1/houses', params: { house: valid_house_attributes } }

      it 'creates a new house into the database' do
        expect(response.status).to(eq(201))
      end
    end

    context 'when the post request is not valid' do
      before do
        post '/api/v1/houses',
             params: {
               house: {
                 name: 'Summer Hat',
                 category: ' ',
                 description: 'Sea side home with huge bedrooms'
               }
             }
      end

      it 'does not create a new house into the database' do
        expect(response.status).to(eq(422))
        expect(json['message']).to(match(/Validation failed: Category can't be blank/i))
      end
    end
  end
end
