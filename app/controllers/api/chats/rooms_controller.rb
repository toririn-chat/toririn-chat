class Api::Chats::RoomsController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @room = current_chat_room
    render json: @room
  end

end
