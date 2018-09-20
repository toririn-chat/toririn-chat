class Api::Chats::RoomsController < Api::ApiController

  # TODO: auth
  def show
    @room = Room.find_by(token: params[:chat_token])
    render json: @room
  end

end
