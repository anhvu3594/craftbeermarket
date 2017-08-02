class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_#{params[:user_id]}"
  end

end
