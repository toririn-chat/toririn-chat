document.addEventListener 'turbolinks:load', ->
  return unless $('body.rooms.index').exists()
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
  $('form.new_user, form.edit_user').on 'ajax:success', (event, data, status, xhr) ->
    $('img.user.icon').attr('src', data.icon_path)
    $('img.user.icon').css('opacity', '1.0')
    $('span.user.name').html(data.name)
    users.modal('hide')
  $('form.new_user, form.edit_user').on 'ajax:error', (event, xhr, status, error) ->
    $.each xhr.responseJSON, (index, message) ->
      # TODO
      console.error message
  $('a#logout[data-remote=true]').on 'ajax:success', (event, data, status, xhr) ->
    window.location.replace(Routes.root_path())
  $('a#logout[data-remote=true]').on 'ajax:error', (event, xhr, status, error) ->
    $.each xhr.responseJSON, (index, message) ->
      # TODO
      console.error message

selectIcon = (name) ->
  icons = $('.gallery img')
  icons.css('opacity', '0.2')
  icons.attr('data-selected', false)
  target = $(".gallery img[data-name='#{name}']")
  target.css('opacity', '1.0')
  target.attr('data-selected', true)
  $('#user_icon').val(name)
