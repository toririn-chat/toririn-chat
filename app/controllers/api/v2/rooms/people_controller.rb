class Api::V2::Rooms::PeopleController < Api::V2::ApiController

  def index
    # TODO auth by qr, token, etc.
    # @room = Room.find(params[:room_id])
    # render json: @room.messages
    render json: []
    # render json: PeopleMessage.includes(:user).where(room_id:params[:room_id])
  end

end
