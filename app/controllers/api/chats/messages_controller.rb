class Api::Chats::MessagesController < Api::ApiController
  # TODO
  def index
    render json: Message.all
  end
end
