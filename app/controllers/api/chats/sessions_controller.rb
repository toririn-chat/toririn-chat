class Api::Chats::SessionsController < Api::ApiController

  def show
    if session[:chat_user_id].present?
      render json: true
    else
      render json: false, status: :unauthorized
    end
  end

  def create
    # トークンと暗証番号を称号
    if Room.where(token: params[:chat_token], code: params[:chat_code]).exists?
      # ユーザを作成
      person = Person.create
      # セッションにユーザIDを追加
      session[:chat_user_id] = person.id
      # 認証完了
      render json: true
    else
      render json: false, status: :unauthorized
    end
  end

end
