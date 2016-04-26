Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'

  # resources :user, only: [:new, :create, ]
end
