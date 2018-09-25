class Api::Chats::AvatarsController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @avatar = Avatar.find_by!(id: params[:id])
    send_data(@avatar.content_data, disposition: 'inline', type: @avatar.content_type)
  end

  def index
    @avatars = Avatar.all
    render json: @avatars, chat_token: params[:chat_token]
  end

end
