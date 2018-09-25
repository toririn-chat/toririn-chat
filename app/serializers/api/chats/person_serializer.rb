class Api::Chats::PersonSerializer < ActiveModel::Serializer

  attributes :name
  belongs_to :avatar

end
