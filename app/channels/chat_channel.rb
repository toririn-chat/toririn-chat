class ChatChannel < ApplicationCable::Channel

  def subscribed
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp '<<<'
    pp params
    pp '<<<'
    stream_from "room_channel_#{params[:token]}"
  end

  def unsubscribed
  end

  # receive a text message
  def text(data)
# m =Message.create!(room_id:Room.find_by(token:'VdpzdnBgY2l1NvpmYrgY').id,text:'aaa', person_id:'1016859169')
    room_id = data['room_id']
    text = data['text']
    message = {
      room_id: Room.find_by(token: room_id).id,
      person_id: current_chat_person.id,
      text: text
    }
    pp message
    m = Message.create!(message)
    pp m

    # TODO: impl
    # pp 'text'
    # pp data
  end

  # receive a stamp message
  def stamp(data)
    # TODO: impl
    pp 'stamp'
    # room_id = data['room_id']
    # stamp = data['stamp']
    # message = {
    #   user_id: current_user.id,
    #   room_id: room_id,
    #   stamp: stamp
    # }
    # Message.create!(message)
  end

  # receive a mark message
  def mark(data)
    # TODO: impl
    pp 'mark'
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
