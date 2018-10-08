module Serializers

  class RoomSerializer
    def initialize(room)
      @room = room
    end
    def to_object
      return {} if @room.blank?
      return {
        id: @room.id,
        name: @room.name,
        messages: @room.messages.includes(:person, person: [:avatar]).map { |message|
          MessageSerializer.new(message).to_object
        },
        avatars: AvatarsSerializer.new(Avatar.all, token: token).to_object,
        stickers: StickersSerializer.new(Sticker.all, token: token).to_object,
      }
    end
    private
      def token
        @room.token
      end
  end

  class MessageSerializer
    def initialize(message)
      @message = message
    end
    def to_object
      return {} if @message.blank?
      return {
        text: @message.text,
        sticker: StickerSerializer.new(@message.sticker, token: token).to_object,
        type: @message.type,
        created_at: @message.created_at,
        person: PersonSerializer.new(@message.person, token: token).to_object
      }.compact
    end
    private
    def token
      @message.room.token
    end
  end

  class PersonSerializer
    def initialize(person, token:)
      @person = person
      @token = token
    end
    def to_object
      return {} if @person.blank?
      return {
        id: @person.id,
        name: @person.name,
        avatar: AvatarSerializer.new(@person.avatar, token: @token).to_object
      }.compact
    end
  end

  class AvatarsSerializer
    def initialize(avatars, token:)
      @avatars = avatars.presence || []
      @token = token
    end
    def to_object
      @avatars.map { |avatar|
        AvatarSerializer.new(avatar, token: @token).to_object
      }
    end
  end

  class AvatarSerializer
    include Rails.application.routes.url_helpers
    def initialize(avatar, token:)
      @avatar = avatar
      @token = token
    end
    def to_object
      return {} if @avatar.blank?
      return {
        id: @avatar.id,
        name: @avatar.name,
        image_url: api_chat_avatar_url(@token, @avatar.id)
      }.compact
    end
  end

  class StickersSerializer
    def initialize(stickers, token:)
      @stickers = stickers.presence || []
      @token = token
    end
    def to_object
      @stickers.map { |sticker|
        StickerSerializer.new(sticker, token: @token).to_object
      }.compact
    end
  end

  class StickerSerializer
    include Rails.application.routes.url_helpers
    def initialize(sticker, token:)
      @sticker = sticker
      @token = token
    end
    def to_object
      return {} if @sticker.blank?
      return {
        id: @sticker.id,
        name: @sticker.name,
        image_url: api_chat_sticker_url(@token, @sticker.id)
      }.compact
    end
  end
end
