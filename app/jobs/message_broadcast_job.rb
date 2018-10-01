class MessageBroadcastJob < ApplicationJob

  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(action, message)
    m = {
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
    ActionCable.server.broadcast("chat_#{message.room.token}", {
      action: action,
      message: m
    })
  end

end
