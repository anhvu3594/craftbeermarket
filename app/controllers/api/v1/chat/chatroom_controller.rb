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
            requires :participants, type: String
          end
          post 'create' do
            participant_ids = params[:participants].split(",")
            if chatroom = Chatroom.create!
              participant_ids.each do |participant_id|
                participant = User.find(participant_id.to_i)
                chatroom.users << participant
                ActionCable.server.broadcast("chatroom_#{participant.id}", chatroom_id: chatroom.id)
              end
            end
            true
          end
        end
      end
    end
  end
end
