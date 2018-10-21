require 'spec_helper'
require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  user = FactoryBot.create(:user)
  category = FactoryBot.create(:category)

  before(:each) do
    token = Auth.generate_token(user)
    request.headers['AUTHORIZATION'] = "Bearer #{token}"
  end

  describe '#index' do
    context 'when category is present' do
      it 'responds with status ok' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#show' do
    let(:payload) { {id: category.id}}
    context 'when category is present' do
      it 'responds with status ok' do
        get :show, payload
        expect(response).to have_http_status(200)
      end
    end

    context 'when category is not present' do
      it 'responds with not found' do
        payload[:id] = Faker::Number.number(2)
        get :show, payload
        expect(response).to have_http_status(404)
      end
    end
  end
end
