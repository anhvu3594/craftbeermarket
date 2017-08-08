class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chatroom, :user, :created_at, :updated_at

  def chatroom
    { id: object.chatroom.id }
  end

  def user
    UserSerializer.new(object.user)
  end
end
