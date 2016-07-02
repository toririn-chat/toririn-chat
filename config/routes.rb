Rails.application.routes.draw do
  get 'rooms/show'
  root to: 'rooms#show'
  mount ActionCable.server => '/cable'
end
