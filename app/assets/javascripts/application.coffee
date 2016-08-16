#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require turbolinks
#= require underscore.string
#= require js-routes
#= require_tree .

jQuery.fn.exists = ->
  Boolean(this.length > 0)

document.addEventListener 'turbolinks:load', ->
  $('body').on 'shown.bs.modal', (e) ->
    $('body').addClass('scroll-disable')
  $('body').on 'hidden.bs.modal', (e) ->
    $('body').removeClass('scroll-disable')
  $('body').on 'touchmove', (e) ->
    if $('.scroll-disable').has($(e.target)).length
      e.preventDefault()
