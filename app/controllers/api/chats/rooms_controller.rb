class Api::Chats::RoomsController < Api::Chats::ApiController

  before_action :chat_session_exists!
  include Rails.application.routes.url_helpers

  def show
    @room = current_chat_room
    @json = {
      name: @room.name,
      messages: @room.messages.includes(:person).map { |message|
        {
          text: message.text,
          created_at: message.created_at,
          person: {
            id: message.person.id,
            name: message.person.name,
            avatar: {
              id: message.person.avatar.id,
              image_url: api_chat_avatar_url(@room.token, message.person.avatar.id)
            }
          }
        }
      },
      avatars: Avatar.all.map{ |avatar|
        {
          id: avatar.id,
          name: avatar.name,
          image_url: api_chat_avatar_url(@room.token, avatar.id)
        }
      }
    }
    render json: @json
  end

end
