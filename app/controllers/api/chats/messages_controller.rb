class Api::Chats::MessagesController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def index
    @messages = current_chat_room.messages
    render json: @messages
  end

end
