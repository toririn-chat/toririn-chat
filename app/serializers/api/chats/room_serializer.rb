class Api::Chats::RoomSerializer < ActiveModel::Serializer

  attributes :name
  has_many :messages
  has_many :avatars

  def avatars
    Avatar.all
  end

end
