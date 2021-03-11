require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }

  # Mock 'Authorization' header
  let(:headers) { { Authorization: generate_token(user.id) } }

  subject(:valid_request_obj) { described_class.new(headers) }
  subject(:invalid_request_obj) { described_class.new({}) }

  describe '#user' do
    context 'when request is valid' do
      it 'returns user object' do
        result = valid_request_obj.user
        expect(result[:user]).to(eq(user))
      end
    end

    context 'when request is invalid' do
      context 'when there is a missing token' do
        it 'raises a Missing token error' do
          expect { invalid_request_obj.user }
            .to(raise_error(ExceptionHandler::MissingToken, 'Missing token'))
        end
      end

      context 'when token is invalid' do
        subject(:invalid_request_obj) do
          described_class.new({ Authorization: generate_token(9) })
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.user }.to(raise_error(ExceptionHandler::InvalidToken, /Invalid token/))
        end
      end
    end

    context 'when token is expired' do
      let(:headers) { { Authorization: generate_expire_token(user.id) } }
      subject(:valid_request_obj) { described_class.new(headers) }

      it 'raises ExceptionHandler::ExpiredSignature error' do
        expect { valid_request_obj.user }.to(raise_error(ExceptionHandler::InvalidToken, 'Signature has expired'))
      end
    end
  end
end
