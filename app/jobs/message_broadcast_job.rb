class MessageBroadcastJob < ApplicationJob

  queue_as :default

  def perform(action, message)
    ActionCable.server.broadcast("chat_#{message.room.token}", {
      action: action,
      message: Serializers::MessageSerializer.new(message).to_object
    })
  end

end
