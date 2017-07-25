module API
  module V1
    class AuthenticationController < Grape::API
      include API::V1::Defaults

      resource :auth do
        desc 'Creates new user then return info and token', entity: API::Entities::User, http_codes: [
          { code: 201, model: API::Entities::User },
          { code: 422, message: 'Validation failed' }
        ]
        params do
          # requires :name, type: String, desc: 'Name'
          # requires :email, type: String, desc: 'Email address'
          # requires :password, type: String, desc: 'Password'
          requires :user, type: API::Entities::UserRequest
        end
        post :sign_up do
          User.create!(permitted_params[:user])
        end

        desc 'Creates and returns access_token if valid login', entity: API::Entities::User, http_codes: [
          { code: 201, model: API::Entities::UserWithToken },
          { code: 404, message: 'Wrong email or password' }
        ]
          params do
              requires :email, type: String, desc: 'email address'
              requires :password, type: String, desc: 'Password'
          end
        post :sign_in do
          user = User.find_by(email: permitted_params[:email].downcase)
          if user && user.authenticate(permitted_params[:password])
            # create token for user
            token = Token.create!(user_id: user.id)
            # return token
            { token: token.access_token, name: user.name, email: user.email, role: user.role }
          else
            error!('Wrong email or password', 404)
          end
        end
      end
    end
  end
end
