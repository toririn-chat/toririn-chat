class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
  end

  # receive a text message
  def text(data)
    room_id = data['room_id']
    text = data['text']
    message = {
      user_id: current_user.id,
      room_id: room_id,
      text: text
    }
    Message.create!(message)
  end

  # receive a stamp message
  def stamp(data)
    room_id = data['room_id']
    stamp = data['stamp']
    message = {
      user_id: current_user.id,
      room_id: room_id,
      stamp: stamp
    }
    Message.create!(message)
  end

  # receive a mark message
  def mark(data)
    type = data['type']
    message_ids = data['message_ids']
    if type == 'read'
      message_ids.each do |message_id|
        user_message = {
          user_id: current_user.id,
          message_id: message_id,
          read: true
        }
        UserMessage.find_or_create_by!(user_message)
      end
    end
  end

end
