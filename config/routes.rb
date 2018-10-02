Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users, skip: %i(registrations sessions confirmations passwords)
  namespace :api, { format: 'json' } do
    namespace :users do
      devise_scope :user do
        post 'signup', to: 'registrations#create'
        post 'signin', to: 'sessions#create'
        get 'signin', to: 'sessions#show'
        delete 'signout', to: 'sessions#destroy'
        get 'confirmations', to: 'confirmations#show'
        post 'confirmations', to: 'confirmations#create'
        post 'passwords', to: 'passwords#create'
        put 'passwords', to: 'passwords#update'
      end
    end
    resource :user, only: [:show]
    resources :rooms do
      member do
        get 'qrcode', { format: 'png' }
        patch 'create_token'
        patch 'delete_token'
      end
    end
    resources :chats, { param: :token } do
      resource :room, only: [:show], module: 'chats'
      resources :messages, only: [:index], module: 'chats'
      resource :person, only: [:show, :update], module: 'chats'
      resources :avatars, only: [:show, :index], module: 'chats'
      scope module: 'chats' do
        post 'signin', to: 'sessions#create'
        get 'signin', to: 'sessions#show'
      end
    end
  end
  root to: 'root#index'
  mount ActionCable.server => '/cable'
  match "/*path", to: 'root#index', via: :get

end
