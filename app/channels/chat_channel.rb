class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:user_id]}"
  end

  # def receive(data)
  #   ActionCable.server.broadcast('ChatChannel', data: true)
  # end
end
