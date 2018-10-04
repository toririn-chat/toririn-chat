class Api::Chats::ApiController < ActionController::API

  def chat_session_create
    # トークンとコードが一致する部屋を見つける
    if Room.exists?(token: chat_token, code: chat_code)
      # 人物を作成
      @person = Person.create!(avatar: Avatar.find(Avatar.pluck(:id).sample))
      # 部屋ごとのセッションを作成する
      session[:chats] ||= {}
      session[:chats][chat_token] = {}
      session[:chats][chat_token]['person_id'] = @person.id
      # 認証成功
      return true
    else
      # 認証失敗
      return false
    end
  end

  def chat_session_destroy
    # 部屋ごとのセッションを削除する
    session[:chats]&.delete(chat_token)
  end

  def current_chat_room
    @chat_room ||= Room.find_by(token: chat_token)
  end

  def current_chat_person
    @chat_person ||= Person.find_by(id: session[:chats]&.dig(chat_token, 'person_id'))
  end

  def chat_session_exists?
     current_chat_room.present? && current_chat_person.present?
  end

  def chat_session_exists!
    if !chat_session_exists?
      render json: false, status: :unauthorized
    end
  end

  private

    def chat_token
      params[:chat_token]
    end

    def chat_code
      params[:chat_code]
    end

end
