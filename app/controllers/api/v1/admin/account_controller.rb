module API
  module V1
    module Admin
      class AccountController < Grape::API
        include API::V1::Defaults

        resource :account do
          before do
            authenticate_admin!
          end

          desc 'Create new admin account'
          params do
            requires :token, type: String, desc: 'Token'
            requires :account, type: Hash, desc: 'New Account' do
              requires :name, type: String, desc: 'Name of new account'
              requires :email, type: String, desc: 'Email of new account'
              requires :password, type: String, desc: 'Password of new account'
            end
          end
          post :new_admin do
            new_admin = User.create!(name: params[:account][:name], email: params[:account][:email], password: params[:account][:password])
            if new_admin
              new_admin.role = 1
              new_admin.save!
              { status: 200, data: UserSerializer.new(new_admin)}
            else
              new_admin.error
            end
          end
        end
      end
    end
  end
end
