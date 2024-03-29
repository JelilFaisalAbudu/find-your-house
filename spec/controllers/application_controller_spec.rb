require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # create test user
  let!(:user) { create(:user) }
  # set headers for authorization
  let(:headers) { { 'Authorization' => generate_token(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe '#authorize_request' do
    context 'when auth token is not passed' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it 'raises MissingToken error' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end
