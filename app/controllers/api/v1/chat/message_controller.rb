module API
  module V1
    module Chat
      class MessageController < Grape::API
        include API::V1::Defaults

        resource :message do
          # before do
          #   authenticate!
          # end
          desc 'Create message'
          params do
            requires :message, type: Hash, desc: 'Message' do
              requires :content, type: String, desc: 'Message content'
              requires :chatroom_id, type: Integer, desc: 'Chat room id'
              requires :user_id, type: Integer, desc: 'Sender id'
            end
          end
          post 'create' do
            chat_room = Chatroom.find(params[:message][:chatroom_id])
            message = chat_room.messages.create!(params[:message])
            participants = chat_room.users
            participants.each do |participant|
              ActionCable.server.broadcast("chat_#{participant.id}", message: MessageSerializer.new(message))
            end
            message
          end

          desc 'Get messages in chat room'
          params do
            requires :chatroom_id, type: Integer, desc: 'Chat room Id'
          end
          get ':chatroom_id' do
            chatroom = Chatroom.find(params[:chatroom_id])
            chatroom.messages
          end
        end
      end
    end
  end
end
