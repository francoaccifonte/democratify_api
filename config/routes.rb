require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :spotify_songs
  resources :spotify_playlists
  resources :ongoing_playlists, only: %i[update create show destroy]
  resources :accounts, only: %i[show]
  post 'accounts/login', to: 'accounts#login'
  resources :users

  get '/spotify_login', to: 'webhook#spotify_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end