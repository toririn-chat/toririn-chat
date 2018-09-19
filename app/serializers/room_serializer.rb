class RoomSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers
  attributes :id, :name, :created_at, :updated_at
  has_many :authorizations


  # TODO fix
  # attribute :url do
  #   url_forroom_path(id: object.id)
  # end

  # url: true
  # , :url

  # def url
  #   full_url_for(:root)
  #   # ActionController::Base.relative_url_root
  #   # url_for(object)
  # end

  # attributes :id, :text, :created_at, :person_id, :person_name, :person_avatar_image_url, :sticker_image_url
  #
  # def person_id
  #   object&.person&.id
  # end
  #
  # def person_name
  #   object&.person&.name
  # end
  #
  # def person_avatar_image_url
  #   object&.person&.avatar&.image_url
  # end
  #
  # def sticker_image_url
  #   object&.sticker&.image_url
  # end

end
