class ChatChannel < ApplicationCable::Channel

  def subscribed
    stream_from "chat_#{params[:token]}"
  end

  def unsubscribed
  end

  # receive a text message
  def text(data)
    message = {
      room_id: Room.find_by(token: params[:token]).id,
      person_id: current_chat_person.id,
      text: data['text']
    }
    Message.create!(message)
  end

  # receive a sticker message
  def sticker(data)
    message = {
      room_id: Room.find_by(token: params[:token]).id,
      person_id: current_chat_person.id,
      sticker_id: data['sticker_id']
    }
    Message.create!(message)
  end

  # receive a mark message
  def mark(data)
    pp 'mark(data)'
    # TODO: implement
    # type = data['type']
    # message_ids = data['message_ids']
    # if type == 'read'
    #   message_ids.each do |message_id|
    #     user_message = {
    #       user_id: current_user.id,
    #       message_id: message_id,
    #       read: true
    #     }
    #     UserMessage.find_or_create_by!(user_message)
    #   end
    # end
  end

end
