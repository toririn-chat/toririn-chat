class Api::Chats::SessionsController < Api::Chats::ApiController

  def show
    if chat_session_exists?
      render json: true
    else
      render json: false, status: :unauthorized
    end
  end

  def create
    if chat_session_create(params[:chat_token], params[:chat_code])
      render json: true
    else
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
