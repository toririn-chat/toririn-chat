Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users, skip: [:registrations, :sessions, :confirmations]
  namespace :api, { format: 'json' } do
    namespace :v2 do
      devise_scope :user do
        post 'signup', to: 'registrations#create'
        post 'signin', to: 'sessions#create'
        delete 'signout', to: 'sessions#destroy'
        get 'confirmations', to: 'confirmations#show'
        post 'confirmations', to: 'confirmations#create'
        post 'passwords', to: 'passwords#create'
        put 'passwords', to: 'passwords#update'
      end
      resources :rooms, only: [:index], format:'json' do
      end
    end
  end
  resources :users

  root to: 'root#index'
  mount ActionCable.server => '/cable'
  match "/*path", to: 'root#index', via: :get

end
