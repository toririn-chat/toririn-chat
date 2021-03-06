class Api::Rooms::MessagesController < Api::ApiController

  def index
    @messages = Message.includes({person:[:avatar]}, :sticker).where(room_id:params[:room_id])
    render json: @messages
  end

end
