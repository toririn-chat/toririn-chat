class Api::RoomsController < Api::ApiController

  before_action :authenticate_user!
  before_action :set_rooms, only: %i(index)
  before_action :set_room, only: %i(show qrcode update destroy)

  def index
    render json: @rooms.sort{ |room| room.created_at }
  end

  def show
    render json: @room
  end

  def qrcode
    url = root_url + "chats/#{@room.token}"
    @code = RQRCode::QRCode.new(url).as_png
    send_data(@code.to_s, disposition: 'inline', type: 'image/png')
  end

  def create
    @room = Room.new(room_params)
    @room.users << current_user
    if @room.save
      render json: @room, status: :created, location: api_room_url(@room)
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
  end

  private

    def set_rooms
      @rooms = current_user.rooms
    end

    def set_room
      @room = current_user.rooms.where(id:params[:id]).first
    end

    def room_params
      params.require(:room).permit(:id, :name)
    end

end
