#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require turbolinks
#= require underscore.string
#= require js-routes
#= require_tree .

# utils
jQuery.fn.exists = ->
  Boolean(this.length > 0)

# HACK to avoid WebKit Bugs
# https://github.com/twbs/bootstrap/issues/15852
# http://getbootstrap.com/getting-started/#support-fixed-position-keyboards
$('body').on 'touchmove', (e) ->
  if($('.scroll-disable').has($(e.target)).length)
    e.preventDefault()
$('body').on 'shown.bs.modal', ->
  $(this).addClass('scroll-disable')
$('body').on 'hidden.bs.modal', ->
  $(this).removeClass('scroll-disable')
