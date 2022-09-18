Rails.application.routes.draw do
  
  get '/reports', to: 'reports#index'
  get '/reports/download', to: 'reports#download'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :service_types
  resources :parcels
  resources :addresses
  resources :users

  post '/users/create_user', to: 'users#create_user', as: 'create_user'

  root to: 'parcels#index'
  get '/search', to: 'search#index', as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
