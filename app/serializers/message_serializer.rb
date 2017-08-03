class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chatroom, :user, :created_at, :updated_at
  
  def chatroom
    ChatroomSerializer.new(object.chatroom)
  end

  def user
    UserSerializer.new(object.user)
  end
end
