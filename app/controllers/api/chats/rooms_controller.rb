class Api::Chats::RoomsController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @room = current_chat_room
    render json: @room, include: ['messages', 'messages.person', 'messages.person.avatar', 'avatars'], chat_token: params[:chat_token]
  end

end
