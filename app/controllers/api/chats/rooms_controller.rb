class Api::Chats::RoomsController < Api::ApiController

  # TODO
  def show
    render json: {
      name: 'チャットルーム'
    }
  end

end
