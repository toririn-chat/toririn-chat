class Api::Chats::SessionsController < Api::Chats::ApiController

  def show
    if chat_session_exists?
      render json: true
    else
      render json: false, status: :unauthorized
    end
  end

  def create
    if chat_session_create
      render json: true
    else
      # TODO: refactor
      error = {
        chat_code: ['が違います。']
      }
      render json: error, status: :unauthorized
    end
  end

  def destroy
    chat_session_destroy
    render json: true
  end

end
