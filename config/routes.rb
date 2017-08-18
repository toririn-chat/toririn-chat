Rails.application.routes.draw do
  devise_for :users
  resources :rooms

  get :admin, to: 'admin#index'
  namespace :admin do
    resources :rooms do
      resources :messages do
        collection do
          delete :destroy_all
        end
      end
    end
  end
  resources :users
  delete :logout, to:'sessions#destroy'
  root to: 'root#index'
  get :about, to: 'root#about'
  mount ActionCable.server => '/cable'
end
