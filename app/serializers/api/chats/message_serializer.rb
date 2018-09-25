class Api::Chats::MessageSerializer < ActiveModel::Serializer

  attributes :text, :created_at
  belongs_to :person

end
