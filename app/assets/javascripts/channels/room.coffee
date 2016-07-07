App.room = null

current_user_id = ->
  0

current_room_id = ->
  $('#room').data('id')

current_room_ch = ->
  id = current_room_id()
  if id?
    return {channel: 'RoomChannel', room_id: id}
  else
    return null


document.addEventListener 'turbolinks:request-start', ->
  if current_room_ch()?
    App.room.unsubscribe()

document.addEventListener 'turbolinks:load', ->
  if current_room_ch()?
    window.scrollTo(0, document.body.scrollHeight)
    App.room = App.cable.subscriptions.create current_room_ch() ,
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
      App.room.speak(current_user_id(), current_room_id(), value)
      event.target.value = ''
      event.preventDefault()

$(document).on 'click', '#button', (event) ->
  value = $('#text').val()
  if value.length != 0
    $('#text').val('')
    App.room.speak(current_user_id(), current_room_id(), value)
