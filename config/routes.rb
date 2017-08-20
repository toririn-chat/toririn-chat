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
      end
    end
  end

  root to: 'root#index'
  mount ActionCable.server => '/cable'
  match "/*path", to: 'root#index', via: :get

end
