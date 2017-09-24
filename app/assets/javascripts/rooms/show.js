// $(document).on 'turbolinks:load', ->
//   return unless $('body.rooms.show').exists()
//
//   # functions
//
//   scrollToBottom = ->
//     window.scrollTo(0, document.body.scrollHeight)
//
//   updateButtonState = ->
//     if $('#text').val().length is 0
//       $('#button').attr('disabled', 'disabled')
//     else
//       $('#button').removeAttr('disabled')
// 
//   sendText = ->
//     value = $('#text').val()
//     if value.length > 0
//       App.room.text(value)
//       $('#text').val('')
//
//   # events
//
//   $('#text').on 'keydown keyup keypress', (event) ->
//     updateButtonState()
//
//   $('#text').on 'keypress', (event) ->
//     if event.keyCode is 13
//       sendText()
//       updateButtonState()
//       event.preventDefault()
//
//   $('#button').on 'click', (event) ->
//     sendText()
//
//   $('#stamps .gallery img').on 'click', (event) ->
//     stamp_name = $(event.target).data('name')
//     App.room.stamp(stamp_name)
//     $('#stamps').modal('hide')
//
//   $('#stamps').on 'shown.bs.modal', ->
//     scrollToBottom()
//
//   $('#stamps').on 'hidden.bs.modal', ->
//     scrollToBottom()
//
//   # main
//
//   updateButtonState()
