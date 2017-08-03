module API
  module V1
    module Chat
      class ChatroomController < Grape::API
        include API::V1::Defaults

        resource :chatroom do
          # before do
          #   authenticate!
          # end
          desc 'Create a chat room'
          params do
            requires :participants, type: String, desc: 'Participants in chat room, a string of ids'
          end
          post 'create' do
            participant_ids = params[:participants].split(",")
            if chatroom = Chatroom.create!
              participant_ids.each do |participant_id|
                participant = User.find(participant_id.to_i)
                chatroom.users << participant
                ActionCable.server.broadcast("chatroom_#{participant.id}", chatroom: ChatroomSerializer.new(chatroom))
              end
            end
            true
          end

          desc 'Show list of chat rooms'
          params do
            requires :user_id, type: Integer, desc: 'User id'
          end
          get ':user_id' do
            user = User.find(params[:user_id])
            user.chatrooms
          end
        end
      end
    end
  end
end
