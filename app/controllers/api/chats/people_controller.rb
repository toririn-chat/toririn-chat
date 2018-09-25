class Api::Chats::PeopleController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    pp '---'
    pp '---'
    pp '---'
    pp '---'
    pp current_chat_person
    render json: current_chat_person
  end

  def update
    args = {
      name: params[:name],
      avatar_id: params[:avatar_id]
    }
    @person = current_chat_person
    if @person.update(args)
      render json: true
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

end
