class RoomSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :name, :begin_at, :end_at, :token, :code, :created_at, :updated_at

  attribute :url do
    root_url + "chats/#{object.token}"
  end

  attribute :qrcode_url do
    qrcode_api_room_url(object)
  end

end
