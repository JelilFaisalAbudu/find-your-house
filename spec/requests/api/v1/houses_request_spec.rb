require 'rails_helper'

RSpec.describe "Api::V1::Houses", type: :request do
  describe 'GET /api/v1/houses' do
    before { get '/api/v1/houses' }
    it 'returns all houses' do
      expect(response).to(have_http_status(200))   
    end
  end
end
