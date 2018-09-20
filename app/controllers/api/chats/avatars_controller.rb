class Api::Chats::AvatarsController < Api::ApiController

  # TODO auth
  def show
    avatar = Avatar.find_by(id: params[:id])
    send_data(avatar.data, disposition: 'inline', type: avatar.content_type)
  end

end
