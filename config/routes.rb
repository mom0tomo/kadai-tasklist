Rails.application.routes.draw do
  root to: 'tasks#index'

  resources :sessions, only: [:update]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:show, :create]
  get 'signup', to: 'users#new'

  resources :tasks
end
