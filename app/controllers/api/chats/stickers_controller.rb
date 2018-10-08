class Api::Chats::StickersController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @sticker = Sticker.find_by!(id: params[:id])
    send_data(@sticker.content_data, disposition: 'inline', type: @sticker.content_type)
  end

end
