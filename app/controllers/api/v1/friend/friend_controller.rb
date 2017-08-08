module API
  module V1
    module Friend
      class FriendController < Grape::API
        include API::V1::Defaults

        resource :friend do
          before do
            authenticate!
          end

          desc 'Find a friend by name'
          params do
            requires :token, type: String, desc: 'Token'
            requires :name, type: String, desc: 'Friend name'
          end
          get 'find' do
            User.where(name: params[:name])
          end

          desc 'Add a friend'
          params do
            requires :token, type: String, desc: 'Token', documentation: { param_type: 'query' }
            requires :friend_id, type: Integer, desc: 'Friend id'
          end
          post 'add' do
            new_friend = User.find(params[:friend_id])
            @current_user.friends << new_friend
            new_friend.friends << @current_user
            new_friend
          end

          desc 'Get list of friends'
          params do
            requires :token, type: String, desc: 'Token'
          end
          get '' do
            @current_user.friends
          end
        end
      end
    end
  end
end
