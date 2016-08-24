class MessageBroadcastJob < ApplicationJob

  queue_as :default

  def perform(action, message)
    html_message = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    ActionCable.server.broadcast("room_channel_#{message.room_id}", action:action, message:html_message)
  end

end
