module API
  module V1
    module Admin
      class AccountController < Grape::API
        include API::V1::Defaults

        resource :admin_account do
          before do
            authenticate_admin!
          end

          # desc 'Create new admin account'
          # , entity: API::Entities::User, http_codes: [
          #   { code: 201, model: API::Entities::User },
          #   { code: 422, message: 'Validation failed' }
          # ]
          desc 'Create new admin account'
          params do
            requires :token, type: String, desc: 'Token', documentation: {
              param_type: 'query'
            }
            requires :account, type: Hash, desc: 'New Account' do
              requires :name, type: String, desc: 'Name of new account'
              requires :email, type: String, desc: 'Email of new account'
              requires :password, type: String, desc: 'Password of new account'
            end
          end
          post :new_admin do
            new_admin = User.create!(permitted_params[:account])
            new_admin.role = 1
            UserSerializer.new(new_admin) if new_admin.save!
          end
        end
      end
    end
  end
end
