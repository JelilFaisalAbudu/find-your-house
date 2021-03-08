require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe Authenticable, type: :module do
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:password) { user.password }
  let(:authentication) { MockController.new }

  context 'when the user is authenticated' do
    it 'should get user Authorization token' do
      authentication.request.headers['Authorization'] =
        JsonWebToken.encode(user_id: user.id)
      expect(authentication.current_user).not_to(eq(nil))
      expect(authentication.current_user.id).to(eq(user.id))
    end
  end

  context 'when the user is not authenticated' do
    it 'should not get user Authorization token' do
      authentication.request.headers['Authorization'] = nil
      expect(authentication.current_user).to(eq(nil))
    end
  end
end
