# functions

getRoomID = ->
  $('#params').data('room-id')

getUnreadMessageIDs = ->
  user_id = $('#params').data('user-id')
  message_ids = ($(m).data('id') for m in $('.message') when (user_id not in $(m).data('readers')))
  return message_ids

addMessage = (message) ->
  $('.messages').append(message)

scrollToBottom = ->
  window.scrollTo(0, document.body.scrollHeight)

room_subscription =
  # WebSocket Events Handlers
  connected: ->
    this.mark('read')
    scrollToBottom()
  received: (data) ->
    addMessage(data['message'])
    scrollToBottom()
    this.mark('read')
  disconnected: ->
    # noop
  rejected: ->
    # noop
  # App defined Actions
  text: (text) ->
    @perform 'text', {
      room_id: getRoomID()
      text: text
    }
  stamp: (stamp) ->
    @perform 'stamp', {
      room_id: getRoomID()
      stamp: stamp
    }
  mark: (type, message_ids) ->
    @perform 'mark', {
      type: type,
      message_ids: getUnreadMessageIDs()
    }

$(document).on 'turbolinks:load', ->
  if getRoomID()?
    room_identifier = { channel: 'RoomChannel', room_id: getRoomID() }
    App.room = App.cable.subscriptions.create(room_identifier, room_subscription)
  scrollToBottom()

$(document).on 'turbolinks:request-start', ->
  if getRoomID()?
    App.room.unsubscribe()
