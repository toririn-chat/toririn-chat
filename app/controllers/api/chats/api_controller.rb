class Api::Chats::ApiController < ActionController::API

  def chat_session_create(chat_token, chat_code)
    # トークンと暗証番号が一致する部屋を見つける
    @room = Room.find_by(token: chat_token, code: chat_code)
    if @room.present?
      # 人物を作成
      @person = Person.create
      # セッションに記録
      session[:chat_person_id] = @person.id
      session[:chat_room_id] = @room.id
      # 認証成功
      return true
    else
      # 認証失敗
      return false
    end
  end

  def chat_session_destroy
    session[:chat_person_id] = nil
    session[:chat_room_id] = nil
  end

  def current_chat_person
    @chat_person ||= Person.find_by(id: session[:chat_person_id])
  end

  def current_chat_room
    @chat_room ||= Room.find_by(id: session[:chat_room_id])
  end

  def chat_session_exists?
    current_chat_person.present? && current_chat_room.present?
  end

  def chat_session_exists!
    if !chat_session_exists?
      render json: false, status: :unauthorized
    end
  end

end
