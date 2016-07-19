Rails.application.routes.draw do
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
  root to: 'root#index'
  get :about, to: 'root#about'
  mount ActionCable.server => '/cable'
end
