require 'spec_helper'
require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  user = FactoryBot.create(:user)

  describe '#login' do
    let(:payload) { { email: user.email, password: user.password } }
    context 'when email and password matches' do
      it 'responds with status ok' do
        post :login, payload
        expect(response).to have_http_status(200)
      end
    end

    context 'when email and password do not match' do
      it 'responds with unauthorized' do
        payload[:email] = Faker::Internet.unique.email
        get :login, payload
        expect(response).to have_http_status(401)
      end
    end
  end
end
