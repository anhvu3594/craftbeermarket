module API
  module V1
    module Admin
      class UserAccount < Grape::API
        include API::V1::Defaults

        resource :user do
          before do
            authenticate!
            error!('You are not admin.', 401) unless @current_user.is_admin?
            # puts @current_user.role
          end

          desc 'Create new admin account'
          params do
            requires :token, type: String, desc: "Token"
            requires :name, type: String, desc: "Name of new account"
            requires :email, type: String, desc: "Email of new account"
            requires :password, type: String, desc: "Password of new account"
          end
          post :new_admin do
            new_admin = User.create!(name: params[:name], email: params[:email], password: params[:password])
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
