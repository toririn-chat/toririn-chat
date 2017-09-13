class Api::V2::Rooms::MessagesController < Api::V2::ApiController

  def index
    # TODO auth by qr, token, etc.
    # @room = Room.find(params[:room_id])
    # render json: @room.messages
    render json: Message.includes(:user).where(room_id:params[:room_id])
  end

end
