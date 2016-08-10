document.addEventListener 'turbolinks:load', ->
  return unless $('body.rooms.show').exists()
  $('.gallery img').on 'click', (event) ->
    stamp_name = $(event.target).data('name')
    App.room.stamp(stamp_name)
    $('#stamps').modal('hide')
