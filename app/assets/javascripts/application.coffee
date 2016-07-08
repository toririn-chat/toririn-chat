#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require turbolinks
#= require_tree .

jQuery.fn.exists = ->
  Boolean(this.length > 0)
