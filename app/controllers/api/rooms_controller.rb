class Api::RoomsController < Api::ApiController

  before_action :authenticate_user!
  before_action :set_rooms, only: %i(index)
  before_action :set_room, only: %i(show qrcode update destroy)
  include Rails.application.routes.url_helpers

  def index
    render json: @rooms.sort{ |room|
      room.created_at
    }.map{ |room|
      {
        id: room.id,
        name: room.name,
        created_at: room.created_at
      }
    }
  end

  def show
    render json: {
      id: @room.id,
      name: @room.name,
      begin_at: @room.begin_at,
      end_at: @room.end_at,
      token: @room.token,
      code: @room.code,
      created_at: @room.created_at,
      url: "#{root_url}chats/#{@room.token}",
      qrcode_image_url: qrcode_api_room_url(@room)
    }
  end

  def create
    @room = Room.new(room_params)
    @room.users << current_user
    @room.token = Room.generate_token
    @room.code = Room.generate_code
    if @room.save
      render json: @room, status: :created
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

  def qrcode
    # TODO: refactoring
    url = root_url + "chats/#{@room.token}"
    @code = RQRCode::QRCode.new(url).as_png(border_modules: 1, module_px_size: 3)
    send_data(@code.to_s, disposition: 'inline', type: 'image/png')
  end

  private

    def set_rooms
      @rooms = current_user.rooms
    end

    def set_room
      @room = current_user.rooms.where(id: params[:id]).first
    end

    def room_params
      params.require(:room).permit(:id, :name)
    end

end
