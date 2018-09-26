class Api::Chats::PersonSerializer < ActiveModel::Serializer

  attributes :id, :name, :avatar_id
  belongs_to :avatar

end
