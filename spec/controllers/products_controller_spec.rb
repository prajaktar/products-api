require 'spec_helper'
require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  user = FactoryBot.create(:user)
  category = FactoryBot.create(:category)
  product = FactoryBot.create(:product, category_id: category.id)

  before(:each) do
    token = Auth.generate_token(user)
    request.headers['AUTHORIZATION'] = "Bearer #{token}"
  end

  describe '#index' do
    context 'when product is present' do
      it 'responds with status ok' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#show' do
    let(:payload) { {id: product.id}}
    context 'when product is present' do
      it 'responds with status ok' do
        get :show, payload
        expect(response).to have_http_status(200)
      end
    end

    context 'when product is not present' do
      it 'responds with not found' do
        payload[:id] = Faker::Number.number(2)
        get :show, payload
        expect(response).to have_http_status(404)
      end
    end
  end

  describe '#update' do
    let(:payload) { { id: product.id, name: Faker::Lorem.word, price: Faker::Number.number(2), quantity: Faker::Number.number(2) } }
    context 'when product is present' do
      it 'responds with status ok' do
        patch :update, payload
        expect(response).to have_http_status(200)
      end
    end

    context 'when product is not present' do
      it 'responds with not found' do
        payload[:id] = Faker::Number.number(2)
        patch :update, payload
        expect(response).to have_http_status(404)
      end
    end
  end

  describe '#create' do
    let(:payload) { { category_id: category.id, name: Faker::Lorem.word, price: Faker::Number.number(2), quantity: Faker::Number.number(2) } }
    context 'when product created' do
      it 'responds with status ok' do
        post :create, payload
        expect(response).to have_http_status(200)
      end
    end

    context 'when category not present' do
      it 'responds with not found' do
        payload[:category_id] = 0
        post :create, payload
        expect(response).to have_http_status(404)
      end
    end
  end

  describe '#download' do
    context 'when csv generation fails' do
      it 'responds with not found' do
        payload  = { category_id: 0 }
        post :download, payload
        expect(response).to have_http_status(404)
      end
    end
  end
end
