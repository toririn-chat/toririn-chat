Rails.application.routes.draw do
  resources :rooms
  resources :users
  root to: 'rooms#index'
  get :about, to: 'about#index'
  mount ActionCable.server => '/cable'
end
