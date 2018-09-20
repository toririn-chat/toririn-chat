class Api::Chats::MessagesController < Api::ApiController

  # TODO: auth
  def index
    @messages = Room.find_by(token: params[:chat_token]).messages
    render json: @messages
  end

end
