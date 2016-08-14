document.addEventListener 'turbolinks:load', ->
  return unless $('body.rooms.show').exists()

  # functions

  updateButtonState = ->
    if $('#text').val().length is 0
      $('#button').attr('disabled', 'disabled')
    else
      $('#button').removeAttr('disabled')

  sendText = ->
    value = $('#text').val()
    if value.length > 0
      $('#text').val('')
      App.room.text(value)
      updateButtonState()

  # events

  $('.gallery img').on 'click', (event) ->
    stamp_name = $(event.target).data('name')
    App.room.stamp(stamp_name)
    $('#stamps').modal('hide')

  $('#text').on 'keydown keyup keypress', (event) ->
    updateButtonState()

  $('#text').on 'keypress', (event) ->
    if event.keyCode is 13
      sendText()
      event.preventDefault()

  $('#button').on 'click', (event) ->
    sendText()

  # main

  window.scrollTo(0, document.body.scrollHeight)
  updateButtonState()
