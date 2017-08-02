class ChatChannel < ApplicationCable::Channel
  # def subscribed
  #   stream_from "chat_#{params[:room]}"
  # end

  # def receive(data)
  #   ActionCable.server.broadcast('ChatChannel', data: true)
  # end
end
