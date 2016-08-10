document.addEventListener 'turbolinks:load', ->
  return unless $('body.rooms.show').exists()
  $('.gallery img').on 'click', (event) ->
    stamp_name = $(event.target).data('name')
    on_select_stamp(stamp_name)

current_user_id = ->
  $('#params').data('user-id')

current_room_id = ->
  $('#params').data('room-id')

on_select_stamp = (stamp_name) ->
  $('#stamps').modal('hide')
  App.room.stamp(current_user_id(), current_room_id(), stamp_name)
