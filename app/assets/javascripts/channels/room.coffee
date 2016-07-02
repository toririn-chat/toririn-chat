App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#messages').append data['message']
    window.scrollTo(0, document.body.scrollHeight)

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    console.log event.target.value
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

$(document).on 'click', '#button', (event) ->
  value = $('#text').val()
  if value.length != 0
    App.room.speak value
