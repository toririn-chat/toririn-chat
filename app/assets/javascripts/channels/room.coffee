App.room = null
subscription =
  received: (data) ->
    $('ul.messages').append data['message']
    window.scrollTo(0, document.body.scrollHeight)
  text: (text) ->
    @perform 'text', {
      user_id: this.current_user_id()
      room_id: this.current_room_id()
      text: text
    }
  stamp: (stamp) ->
    @perform 'stamp', {
      user_id: this.current_user_id()
      room_id: this.current_room_id()
      stamp: stamp
    }
  current_user_id: ->
    $('#params').data('user-id')
  current_room_id: ->
    $('#params').data('room-id')

current_room_ch = ->
  id = $('#params').data('room-id')
  return {channel: 'RoomChannel', room_id: id} if id?

document.addEventListener 'turbolinks:request-start', ->
  if current_room_ch()?
    App.room.unsubscribe()

document.addEventListener 'turbolinks:load', ->
  if current_room_ch()?
    App.room = App.cable.subscriptions.create(current_room_ch(), subscription)
    window.scrollTo(0, document.body.scrollHeight)

$(document).on 'keypress', '#text', (event) ->
  if event.keyCode is 13
    value = event.target.value
    if value.length != 0
      App.room.text(value)
      event.target.value = ''
      event.preventDefault()

$(document).on 'click', '#button', (event) ->
  value = $('#text').val()
  if value.length != 0
    $('#text').val('')
    App.room.text(value)
