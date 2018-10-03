class Api::Chats::PeopleController < Api::Chats::ApiController

  before_action :chat_session_exists!

  def show
    @room = current_chat_room
    @person = current_chat_person
    render json: {
      name: @person.name,
      avatar: {
        id: @person.avatar.id,
        name: @person.avatar.name,
        image_url: api_chat_avatar_url(@room.token, @person.avatar.id)
      }
    }
  end

  def update
    args = {
      name: person_params[:name],
      avatar_id: person_params[:avatar_id]
    }
    @person = current_chat_person
    if @person.update(args)
      render json: true
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  private

    def person_params
      params.require(:person).permit(:id, :name, :avatar_id)
    end

end
