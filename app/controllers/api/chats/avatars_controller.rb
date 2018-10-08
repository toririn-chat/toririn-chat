class Api::Chats::AvatarsController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @avatar = Avatar.find_by!(id: params[:id])
    send_data(@avatar.content_data, disposition: 'inline', type: @avatar.content_type)
  end

end
