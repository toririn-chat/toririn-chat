class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
  end

  def text(data)
    message = {
      user_id: data['user_id'],
      room_id: data['room_id'],
      text: data['text']
    }
    Message.create! message
  end

  def stamp(data)
    message = {
      user_id: data['user_id'],
      room_id: data['room_id'],
      stamp: data['stamp']
    }
    Message.create! message
  end

end
