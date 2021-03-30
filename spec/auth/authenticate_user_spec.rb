require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new(user.email, 'invalid_P@$$$') }

  describe '#user' do
    context 'when user credentials a valid' do
      it 'returns an auth token' do
        token = valid_auth_obj.user
        expect(token).not_to(be_nil)
      end
    end

    context 'when user credentials are not valid' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.user }
          .to(
            raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
          )
      end
    end
  end
end
