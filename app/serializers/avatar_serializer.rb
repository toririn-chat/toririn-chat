class AvatarSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :name, :url

  attribute :url do
    api_chat_avatar_url(@instance_options[:chat_token], object.id)
  end

end
