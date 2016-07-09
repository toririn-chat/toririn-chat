Rails.application.routes.draw do
  resources :rooms
  resources :users
  root to: 'root#index'
  get :about, to: 'root#about'
  mount ActionCable.server => '/cable'
end
