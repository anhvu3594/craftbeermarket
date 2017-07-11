module API
  module V1
    class Authentication < Grape::API
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
          if user
            { status: 200, data: UserSerializer.new(user)}
          else
            user.error
          end
        end
      end
    end
  end
end
