module API
  module V1
    class AuthenticationController < Grape::API
      include API::V1::Defaults

      resource :auth do
        desc 'Creates new user then return info and token'
        params do
          requires :name, type: String, desc: 'Name'
          requires :email, type: String, desc: 'Email address'
          requires :password, type: String, desc: 'Password'
        end
        post :sign_up do
          user = User.create!(name: params[:name], email: params[:email], password: params[:password])
          user
        end

        desc 'Creates and returns access_token if valid login'
          params do
              requires :email, type: String, desc: 'email address'
              requires :password, type: String, desc: 'Password'
          end
        post :sign_in do
          user = User.find_by(email: params[:email].downcase)
          if user && user.authenticate(params[:password])
            # create token for user
            token = Token.create!(user_id: user.id)
            # return token
            { token: token.access_token, name: user.name, email: user.email, role: user.role }
          else
            error!('Unauthorized.', 401)
          end
        end
      end
    end
  end
end
