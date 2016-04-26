Rails.application.routes.draw do
  root 'home#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'recommend', to: 'recommends#create'

  resources :users
  resources :links, only: [:index, :create, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:index, :show, :update], :defaults => { :format => 'json' }
    end
  end
end
