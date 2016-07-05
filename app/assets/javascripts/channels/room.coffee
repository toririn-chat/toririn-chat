unless gon?
  return
room = gon
unless room.id?
  return
App.room = App.cable.subscriptions.create {channel: 'RoomChannel', room_id: room.id} ,

  connected: ->

  disconnected: ->

  received: (data) ->
    $('#messages').append data['message']
    window.scrollTo(0, document.body.scrollHeight)

  speak: (user_id, room_id, content) ->
    @perform 'speak', {
      user_id: user_id
      room_id: room_id
      content: content
    }

$(document).on 'keypress', '#text', (event) ->
  if event.keyCode is 13
    value = event.target.value
    if value.length != 0
      App.room.speak(0, room.id, value)
      event.target.value = ''
      event.preventDefault()

$(document).on 'click', '#button', (event) ->
  value = $('#text').val()
  if value.length != 0
    $('#text').val('')
    App.room.speak(0, room.id, value)
