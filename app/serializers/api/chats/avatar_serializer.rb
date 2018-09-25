class Api::Chats::AvatarSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :name

  attribute :image_url do
    api_chat_avatar_url(@instance_options[:chat_token], object.id)
  end

end
