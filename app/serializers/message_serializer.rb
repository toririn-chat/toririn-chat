class MessageSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :text, :created_at, :person_id, :person_name, :person_avatar_image_url

# , :person_avatar_image_url, :sticker_image_url

  def person_id
    object&.person&.id
  end

  def person_name
    object&.person&.name
  end

  def person_avatar_image_url
    api_chat_avatar_url(chat_token: object.room.token, id: object&.person&.avatar.id)
  end
  #
  # def sticker_image_url
  #   object&.sticker&.image_url
  # end

end
