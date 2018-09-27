class MessageBroadcastJob < ApplicationJob

  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(action, message)
    # html_message = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    x = {
      id: message.id,
      text: message.text,
      created_at: message.created_at,
      person: {
        id: message.person.id,
        name: message.person.name,
        avatar: {
          id: message.person.avatar.id,
          image_url: api_chat_avatar_url(message.room.token, message.person.avatar.id)
        }
      }
    }
    ActionCable.server.broadcast("room_channel_#{message.room.token}", action:action, message: x)
  end

end
