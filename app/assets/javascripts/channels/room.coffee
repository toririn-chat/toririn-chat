App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#messages').append data['message']
    window.scrollTo(0, document.body.scrollHeight)

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '#text', (event) ->
  if event.keyCode is 13
    value = event.target.value
    if value.length != 0
      App.room.speak value
      event.target.value = ''
      event.preventDefault()

$(document).on 'click', '#button', (event) ->
  value = $('#text').val()
  if value.length != 0
    $('#text').val('')
    App.room.speak value
