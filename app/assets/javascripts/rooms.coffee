document.addEventListener 'turbolinks:load', ->
  if $('body.rooms.index').exists()
    users = $('#users')
    if $('form.new_user').exists()
      icons = $('.gallery img')
      icon = icons[Math.floor(Math.random() * icons.length) + 1]
      icon_name = $(icon).data('name')
      selectIcon(icon_name)
      users.modal {
        keyboard: false
        backdrop: 'static'
      }
    if $('form.edit_user').exists()
      icon_name = $('#user_icon').val()
      selectIcon(icon_name)
    users.on 'shown.bs.modal', ->
      $('#user_name').focus()
    users.on 'hidden.bs.modal', ->
      # noop
    $('.gallery img').on 'click', (event) ->
      icon_name = $(event.target).data('name')
      selectIcon(icon_name)
    $(document).bind 'ajaxSuccess', 'form.new_user', (event, xhr, settings) ->
      user = xhr.responseJSON
      $('img.user.icon').attr('src', user.icon_path)
      $('img.user.icon').css('opacity', '1.0')
      $('span.user.name').html(user.name)
      users.modal('hide')
    $(document).bind 'ajaxError', 'form.new_user', (event, jqxhr, settings, exception) ->
      $.each jqxhr.responseJSON, (index, message) ->
        # TODO
        console.log message

  if $('body.rooms.show').exists()
    users = $('#user-modal')
    console.log 'wwwww'

selectIcon = (name) ->
  icons = $('.gallery img')
  icons.css('opacity', '0.2')
  icons.attr('data-selected', false)
  target = $(".gallery img[data-name='#{name}']")
  target.css('opacity', '1.0')
  target.attr('data-selected', true)
  $('#user_icon').val(name)
