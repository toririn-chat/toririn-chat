setAnima = (path) ->
  animals = $('.animal-list li img')
  animals.css('opacity', '0.2')
  animals.attr('data-selected', false)
  target = $(".animal-list li img[data-path='#{path}']")
  target.css('opacity', '1.0')
  target.attr('data-selected', true)
  $('#user_icon').val(path)

document.addEventListener 'turbolinks:load', ->
  if $('body.rooms.index').exists()
    mo = $('#user-modal')
    if $('form.new_user').exists()
      random = Math.floor(Math.random() * 16) + 1
      path = _.string.sprintf('icons/animal-%02d.png', random)
      setAnima(path)
      mo.modal {
        keyboard: false
        backdrop: 'static'
      }
    if $('form.edit_user').exists()
      path = $('#user_icon').val()
      setAnima(path)

    mo.on 'shown.bs.modal', ->
      $('#user_name').focus()

    mo.on 'hidden.bs.modal', ->
      # noop

    $(document).bind 'ajaxSuccess', 'form.new_user', (event, xhr, settings) ->
      user = xhr.responseJSON
      $('img.user.icon').attr('src', user.icon_path)
      $('img.user.icon').css('opacity', '1.0')
      $('span.user.name').html(user.name)
      mo.modal('hide')

    $(document).bind 'ajaxError', 'form.new_user', (event, jqxhr, settings, exception) ->
      $.each jqxhr.responseJSON, (index, message) ->
        console.log message

    $('.animal-list li').on 'click', (event) ->
      path = $(event.target).data('path')
      setAnima(path)
