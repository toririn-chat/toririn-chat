class Api::Rooms::PeopleController < Api::ApiController

  def index
    # TODO auth by qr, token, etc.
    # @room = Room.find(params[:room_id])
    # render json: @room.messages
    render json: []
    # render json: PeopleMessage.includes(:user).where(room_id:params[:room_id])
  end

end
