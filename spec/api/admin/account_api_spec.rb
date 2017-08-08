require 'rails_helper'

RSpec.describe 'AdminAccountApis', type: :request do
  include_context 'admin token'

  context 'when user is admin' do
    it 'create admin account' do
      user_params = FactoryGirl.attributes_for(:user)

      expect do
        post '/api/v1/admin_account/new_admin', params: {
          token: token,
          account: user_params
        }
      end.to change { User.where(role: 1).count }.by(1)

      expect(response).to have_http_status(201)
    end
  end
end
