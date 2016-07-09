#= require action_cable
#= require_self
#= require_tree ./channels

(->
  @App || (@App = {} )
  App.cable = ActionCable.createConsumer()
  return
).call(this)
