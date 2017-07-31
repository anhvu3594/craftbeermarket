require 'rails_helper'

RSpec.describe 'AdminCategoryApis', type: :request do
  include_context 'admin token'

  context 'when user is admin' do
    it 'load all categories' do
      get '/api/v1/admin_category', params: {
        token: token
      }
      expect(response).to have_http_status(200)
    end

    it 'create category' do
      expect do
        post '/api/v1/admin_category/create', params: {
          token: token,
          category: { name: 'hello' }
        }
      end.to change(Category, :count).by(1)

      expect(response).to have_http_status(201)
    end

    it 'delete category' do
      category = FactoryGirl.create(:category)
      expect do
        delete "/api/v1/admin_category/#{category.id}", params: {
          token: token
        }
      end.to change(Category, :count).by(-1)

      expect(response).to have_http_status(200)
    end
  end

  context 'when user is not admin' do
    it "can't access category's features" do
      get '/api/v1/admin_category', params: {
        token: nil
      }
      expect(response).to have_http_status(401)
    end
  end
end
