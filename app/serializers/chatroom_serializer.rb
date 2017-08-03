class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :users

  def users
    ActiveModel::Serializer::CollectionSerializer.new(object.users, each_serializer: UserSerializer)
  end
end
