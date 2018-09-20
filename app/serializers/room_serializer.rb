class RoomSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :name, :begin_at, :end_at, :token, :code, :created_at, :updated_at, :messages_count, :users_count

  attribute :url do
    root_url + "chats/#{object.token}"
  end

  attribute :qrcode_url do
    qrcode_api_room_url(object)
  end

  attribute :messages_count do
    object.messages.count
  end

  attribute :users_count do
    object.users.count
  end

  has_many :users
  has_many :messages

end
