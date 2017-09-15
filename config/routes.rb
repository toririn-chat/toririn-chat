Rails.application.routes.draw do

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  devise_for :users, skip: %i(registrations sessions confirmations passwords)
  namespace :api, { format: 'json' } do
    namespace :v2 do
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
      resources :rooms do
        resources :messages, module:'rooms'
        resources :people, module:'rooms'
      end
    end
  end

  root to: 'root#index'
  mount ActionCable.server => '/cable'
  match "/*path", to: 'root#index', via: :get

end
