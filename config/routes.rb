Rails.application.routes.draw do
  resources :users
  get 'rooms/show'
  root to: 'rooms#show'
  mount ActionCable.server => '/cable'
end
