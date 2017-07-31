require 'rails_helper'

RSpec.describe 'AdminBeerApis', type: :request do
  include_context 'admin token'

  let! (:beer) { FactoryGirl.create(:beer) }

  context 'when user is admin' do
    it 'load all beers' do
      get '/api/v1/admin_beer', params: {
        token: token
      }
      expect(response).to have_http_status(200)
    end

    it 'load one beer' do
      get "/api/v1/admin_beer/#{beer.id}", params: {
        token: token
      }
      expect(response).to have_http_status(200)
    end

    it 'create beer' do
      category = FactoryGirl.create(:category)
      beer_params = FactoryGirl.attributes_for(:beer)
      beer_params[:category_id] = category.id

      expect do
        post '/api/v1/admin_beer/create', params: {
          token: token,
          beer: beer_params
        }
      end.to change(Beer, :count).by(1)

      expect(response).to have_http_status(201)
    end

    it 'edit beer' do
      require 'json'

      beer_params = beer.attributes.except('id', 'created_at', 'updated_at')
      beer_params['country'] = 'Viet Nam'

      put "/api/v1/admin_beer/edit/#{beer.id}", params: {
        token: token,
        beer: beer_params
      }

      expect(JSON.parse(response.body)['country']).to eq 'Viet Nam'

      expect(response).to have_http_status(200)
    end

    it 'archive beer' do
      put "/api/v1/admin_beer/archive/#{beer.id}", params: {
        token: token
      }

      expect(beer.reload.is_archived).to be_truthy

      expect(response).to have_http_status(200)
    end

    it 'unarchive beer' do
      put "/api/v1/admin_beer/unarchive/#{beer.id}", params: {
        token: token
      }

      expect(beer.reload.is_archived).to be_falsy

      expect(response).to have_http_status(200)
    end

    it 'delete beer' do
      expect do
        delete "/api/v1/admin_beer/delete/#{beer.id}", params: {
          token: token
        }
      end.to change(Beer, :count).by(-1)

      expect(response).to have_http_status(200)
    end
  end

  context 'when user is not admin' do
    it "can't access beer's features" do
      get '/api/v1/admin_beer', params: {
        token: nil
      }

      expect(response).to have_http_status(401)
    end
  end
end
