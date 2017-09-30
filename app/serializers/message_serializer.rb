class MessageSerializer < ActiveModel::Serializer

  attributes :id, :text, :created_at, :person_id, :person_name, :person_avatar_image_url, :sticker_image_url

  def person_id
    object&.person&.id
  end

  def person_name
    object&.person&.name
  end

  def person_avatar_image_url
    object&.person&.avatar&.image_url
  end

  def sticker_image_url
    object&.sticker&.image_url
  end

end
